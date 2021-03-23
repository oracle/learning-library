# Using Skaffold to develop and debug live containers

## Introduction

In the **Kustomize** lab, we saw how resource templates were combined and overlayed to build complete configurations for a specific environment.

**Skaffold** leverages **Kustomize** to render templates and deploy, adding its own layer of templating to fit the need of the development cycle.

In this lab we'll look at the **Skaffold** configuration and usage to develop applications on a remote cluster.


Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

- Understand the additional templating rules for **Skaffold**
- Understand Docker multi-stage builds, to produce different image outputs with a single Dockerfile
- Learn about the different deployment modes in **Skaffold**


## **STEP 1:** The *`skaffold.yaml`* base config file

1. The *`skaffold.yaml`* file configures the different modes **Skaffold** can be used for:

    - *`render`*: render the templates (using **Kustomize** in our config)
    - *`build`*: builds, tags and publishes the docker images referenced in the config
    - *`deploy`* for actual deployment 
    - *`dev`* for development: deploy and run while synchronizing files on change with the live container
    - *`debug`* for development: deploy and run attaching a remote debugger to the live container

2. The config file includes a base set of sections, and then *profiles*. Let's look at the default sections first:

    ```yaml
    apiVersion: skaffold/v2beta11
    kind: Config
    metadata:
    name: demo
    build:
      tagPolicy:
        gitCommit: 
        variant: AbbrevCommitSha
      artifacts:
        - image: consumer
          context: images/consumer
          docker:
            dockerfile: Dockerfile
          sync:
            manual:
            - src: src/**
                dest: .
        - image: producer
          context: images/producer
          sync:
            manual:
            - src: src/**
                dest: .
          docker:
            dockerfile: Dockerfile
        - image: web
          context: images/web
          docker:
            dockerfile: Dockerfile
          sync:
            manual:
            - src: src/**
                dest: .
    # default deploy
    deploy:
      kustomize:
        paths:
        - k8s/overlays/development/app
    ```

3. Note the *`build`* *`artifacts`* section where we define what images need to be built. Not all images in a project need to be built, they could come from an external registry.

4. Here we're building our *`producer`*, *`consumer`* and *`web`* images.

5. The *`context`* defines where the Dockerfile context is located, and the *`docker: dockerfile`* indicates the name of the Dockerfile, which is simply **Dockerfile** here.

6. The *`sync`* section defines what files are synchronized in *`dev`* mode, and where they are mapped to in the container. Here our *`src`* is the *`src/**`* folder and all its content, mapped to the root of the container, as our WORKDIR is `/`.

7. The *`deploy`* section defines how to deploy, with *`kustomize`* and what overlay to deploy.

## **STEP 2:** The Dockerfiles

1. In this step we will look at the Docker images, as it is relevant to the profile section we'll see next.

2. If you look into the *`images`* folder, we have a folder per app/service (*`producer`*, *`consumer`*, *`web`* as well as *`db-config`*)

3. Each Dockerfile has multiple stages. For example, the *`producer`* image is as follow:

    ```Dockerfile
    FROM python:3.9-slim as builder

    ENV PYTHONUNBUFFERED=1

    COPY requirements.txt /requirements.txt
    RUN pip install -r requirements.txt

    COPY src /src

    # Image that allows auto-reload of code when files changes
    # to be used with the sync functionality
    FROM builder as autoreload
    RUN apt-get update \
        && apt-get install -y --no-install-recommends entr procps \
        && rm -rf /var/lib/apt/lists/*

    ENV ENTR_INOTIFY_WORKAROUND=1

    CMD find /src | entr -r python /src/producer.py


    # Output image for debug: same image as builder but with straight Python command
    FROM builder as debug
    CMD ["python", "/src/producer.py"]

    # Output image for prod: same image as builder but with straight Python command
    FROM builder as prod
    CMD ["python", "/src/producer.py"]
    ```

    - We start from a *`python:3.9-slim`* base image as *`builder`* stage

    - Set some ENV variable to avoid buffering logs

    - COPY the requirements.txt file and RUN pip install to install requirements.

    - then COPY the whole *`src`* folder

4. A second stage called *`autoreload`* starts from the *`builder`* stage, and adds some development dependencies to reload the process when files change, using *`entr`*

    The CMD command is set to *`find /src | entr -r python /src/producer.py`* to scan for file changes in the *`src`* folder and relaunch the python process on change.

5. A 3rd stage is used for *`debug`*

6. A 4th stage starting from *`builder`* is labeled as *`prod`* (but is in fact the same as debug)

7. Using these stages, it is possible to build different *versions* of the same image for different stages of the development flow.

    - The *`autoreload`* image will be used in *`dev`* mode to auto-reload the code on file change
    - The *`debug`* image will be used to attach the debugger (Skaffold is picky about the CMD and requires a python program to be starting with the python command to debug it)
    - The *`prod`* image is the final stage and what will be built when no build stage is specified.

## **STEP 3:** The Skaffold profiles

1. The next section of the *`skaffold.yaml`* includes profiles. Just like Kustomize templates, skaffold config uses patches to modify the base config.

2. With a profile, we can define a different deployment overlay for example, or target a different Docker image build stage. This is what we do here:

    ```yaml
    - name: dev
        activation:
        # run this profile when using skaffold dev
        - command: dev
        deploy:
          kustomize:
            paths:
            - k8s/overlays/branch
        patches:
        # add tag prefix to avoid rebuilding over the same hash
        - op: add
            path: /build/tagPolicy/gitCommit/prefix
            value: arl-
        # change the target image to use autoreload when code changes
        - op: add
            path: /build/artifacts/0/docker/target
            value: autoreload
        - op: add
            path: /build/artifacts/1/docker/target
            value: autoreload
        - op: add
            path: /build/artifacts/2/docker/target
            value: autoreload
    ```

3. The *`dev`* profile patches the artifacts (numbered 0,1,2 here) with a *`target`* of *`autoreload`* which indicates the Docker image build stage. It also patches the image *tag* with a prefix *`arl-`* so the image pushed to the registry is different from the `prod` image.

4. The *`debug`* profile patches the artifacts too, to use the *`debug`* build stage, and prefixes the image *tag* with *`dbg-`*

    ```yaml
    - name: debug
        activation:
        # activate this profile when using skaffold debug
        - command: debug
        deploy:
        kustomize:
            paths:
            - k8s/overlays/branch
        patches:
        # add tag prefix to avoid rebuilding over the same hash
        - op: add
            path: /build/tagPolicy/gitCommit/prefix
            value: dbg-
        # change the target image to use debugger from skaffold 
        # requires that python
        - op: add
            path: /build/artifacts/0/docker/target
            value: debug
        - op: add
            path: /build/artifacts/1/docker/target
            value: debug
        - op: add
            path: /build/artifacts/2/docker/target
            value: debug
        portForward:
        - resourceType: Deployment
            resourceName: dev-producer
            port: 5678
            localPort: 5678
        - resourceType: Deployment
            resourceName: dev-consumer
            port: 5678
            localPort: 5679
        - resourceType: Deployment
            resourceName: dev-web
            port: 5678
            localPort: 5680
    ```

    - We also add a *`portForward`* section that defines remote debugger port mapping to the local machine.

5. The other profiles define profiles for regular *`development`* versions, *`staging`* and *`production`*, as well as similar profiles for the *`infra`* image

## **STEP 4:** Deploying the *`infra`* templates with Skaffold

1. *`skaffold build`* builds and pushes artifacts. The *`--default-repo`* flag will add the registry info to all images to be built and published.

    ```bash
    <copy>
    skaffold build --profile=development-infra  --default-repo=YOUR_REGISTRY_NAME/demo
    </copy>
    ```

2. *`skaffold deploy`* needs to be used with *`skaffold build`* the following way:

    ```bash
    <copy>
    skaffold build --profile=development-infra  --default-repo=YOUR_REGISTRY_NAME/demo -q | skaffold deploy --profile=development-infra --default-repo=YOUR_REGISTRY_NAME/demo --build-artifacts -
    </copy>
    ```

3. This is quite a bit to type and remember, so we built a **makefile** to run these commands.

## **STEP 5:** Using the makefile

1. Check the makefile help by running:

    ```bash
    <copy>
    make
    </copy>
    ```

    You should see:

    ```bash
    help                           This help.
    build                          Build, tag and push all images managed by skaffold
    deploy                         Build and Deploy app templates
    deploy-infra                   Build and Deploy infra templates
    delete                         Delete the current stack
    setup                          Setup dependencies
    render                         Render the manifests with skaffold and kustomize
    check-render                   Check if the current render matches the saved rendered manifests
    clean-completed-jobs           Clean completed Job. Skaffold can't update them and fails
    clean-all-jobs                 Clean any Job. Skaffold can't update them and fails
    run                            run the stack, rendering the manifests with skaffold and kustomize
    debug                          run the stack in debug mode, rendering the manifests with skaffold and kustomize
    dev                            run the stack in dev mode, rendering the manifests with skaffold and kustomize
    install-all                    Install environments for all projects
    lint-all                       Lint all python projects
    repo-login                     Login to the registry
    ```

2. Before using the makefile, you'll need to provide your credentials.

3. Create a file called *`dev.env`* at the root of the project from the template:

    ```bash
    <copy>
    cp dev.env.template dev.env
    </copy>
    ```

4. Provide the credentials as indicated:

    ```bash
    TENANCY_NAMESPACE=
    DOCKER_USERNAME={TENANCY_NAMESPACE}/{USERNAME}
    DOCKER_PASSWORD={PASSWORD}
    ```

    DO NOT use quotes for the password.

5. To deploy the *`infra`* templates, simply run:

    ```bash
    <copy>
    make deploy-infra
    </copy>
    ```

    This will deploy the infra templates into the *`dev-ns`* namespace for development

6. To specify another environment, use:

    ```bash
    <copy>
    make deploy-infra ENVIRONMENT=production
    </copy>
    ```

    this will deploy to the *`prod-ns`* namespace using the *`production`* overlays.

7. Note that the *`deploy-infra`* task actually calls *`clean-all-jobs`* before running, because **Skaffold** adds *`runIds`* to each resource labels, however **Jobs** are immutable and the call would fail unless the db-init Job is cleaned up before deploying.

## **STEP 6:** Verify the infra deployment

1. You can verify the deployment was successful by checking out the resources:

    ```bash
    <copy>
    kubectl get all -n dev-ns
    </copy>
    ```

2. You should also see in your OCI console, in your compartment under **Databases -> Autonomous Transaction Processing Database** that a new Database is being provisioned.

    ![](.image/db.png)

3. You will find the **Stream** created under **Analytics -> Streaming** 

    ![](.image/stream.png)


## **STEP 7:** Developing remote containers

1. *`skaffold run`* builds and deploys the stack with image tagged with the git hash, and then stops.

2. *`skaffold dev`* builds and deploys the stack and then watches for file changes, and synchronizes the files with the remote container on file change.

    With the *`dev`* mode using the *`autoreload`* target of the Docker image, which reloads the python process on file change, the container code restarts on each file change.

    The wrapped makefile command can be launched with:

    ```bash
    <copy>
    make dev
    </copy>
    ```

    You will see the logs streamed to your local machine, and sync happening on file change.

    Try adding a newline in one of the source files of one of the app containers and see the change being listed in the logs.

3. For this flow to work well, it is recommended to NOT use auto-save in your editor.

4. You can find the Public IP of the web service with:

    ```bash
    <copy>
    kubectl get service dev-web -n dev-ns
    </copy>
    ```

    Use this public IP in Firefox with *`https://`* scheme to see the demo application.

    ![](.images/demoapp.png)


5. Note when quitting **Skaffold** with *`CTRL+C`*, the deployment of the app is deleted, cleaning all pods.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, February 2021
 - **Last Updated By/Date** - Emmanuel Leroy, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabs). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
