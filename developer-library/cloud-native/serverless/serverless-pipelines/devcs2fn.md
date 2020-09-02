# FaaS and Developer Cloud Service.
This is an optional part for Gigi's pizza serverless LAB, using Developer Cloud Service as DevOps and CI/CD tooling. 

In this optional part you will create:
- [Developer Cloud Service instance](#creating-a-developer-cloud-service-instance)
- [Configure the virtual machine build templates](#build-virtual-machines-configuration-in-devcs)
- [Developer Cloud Service project](#create-new-project-in-devcs)
- [Create GIT repositories for each serverless functions](#create-git-repositories)
- [Clone GIT repositories for each serverless functions](#git-clone-repositories)
- [CI/CD - Jobs Creation](#developer-cloud-service-cicd-for-serverless-jobs)
- [CI/CD - Pipelines](#serverless-app-pipelines)

## **Creating a Developer Cloud Service Instance**
Click in the hamburger icon on the top left side and menu will be shown. There select Platform Services (under More Oracle Cloud Services” Area)-\> Developer menu option.

![](./images/image13.png)

There you will be taken to Developer Cloud Service Welcome Page. Let’s start creating a DevCS instance. Click in Create Instance.

![](./images/image14.png)

In next screen provide an Instance Name and fill in also Region you want to create your instance, then click in Next Button:

![](./images/image15.png)

Check the selections in previous screen an click in Create button:

![](./images/image16.png)

Instance creation starts creating service as you can see in Status screen:

![](./images/image17.png)

This process will take some time so let’s take advantage of time while this process ends, and we can then configure the Developer Cloud Service Instance.

## **Configuring a Developer Cloud Service Instance**

Now let’s check that Developer Cloud Service has been created so that we can configure it.

Check updated status by clicking in ![](./images/image32.png) icon:

![](./images/image33.png)

Once the Developer Cloud Service instance has been provisioned, click on the right side menu and select: “Access Service Instance”:

![](./images/image34.png)

You will see next screen where you are requested to run some extra configurations related with Compute & Storage. Click in OCI Credentials link in Message and have close to you the txt file with OCI information previously gathered:

![](./images/image35.png)

Select OCI for Account type and fill in the rest of the fields. Leave passphrase blank and also check the box below.

Then click on validate button and if compute and storage connections are correct, then click on Save button.

![](./images/image36.png)

### Virtual Machines Template configuration in DevCS

Now we need to configure one server to be able to build your project developments. We will create a VM Build Server to be used to compile and Build Fn Function (Serverless) components that will require a different set of Software components.

![](./images/image37.png)

To do this, we have to create a first virtual Machine Template to be used with Microservices, so click in Virtual Machines Templates tab:

![](./images/image38.png)

We will create a Virtual Machine Template for Serverless Components. Click in Create Template fill in fields and click on Create button:

![](./images/image44.png)

Now we will select specific Software components required for Fn Function build process. Click in Configure Software button:

![](./images/image45.png)

Now configure software components. Fn 0 will have to be selected together with Docker, OCIcli, Python and required build VM
components. No Node JS and Java components this time required:

![](./images/image46.png)

Click on Done and these are the software components in VM template:

![](./images/image47.png)

### Build Virtual Machines configuration in DevCS

Now we have to create a couple of real VM in OCI based in Virtual Machine template just created. So, we will select Build Virtual Machines Tab and will click on Create button:

![](./images/image48.png)

Now Select 1 as quantity, select the previously created template, your region and finally select as Shape the option VM.Standard.E2.1 or E2.2 (depends on your tenancy service limits):

![](./images/image52.png)

Now your VM will start creation process

![](./images/image50.png)

It is important to modify to Sleep Timeout a recommend value of 300 minutes (basically longer than lab duration) so that once started, the build server won’t automatically enter into sleep mode.

![](./images/image51.png)

![](./images/image53.png)

IMPORTANT NOTE: At this point try to manually start VM Server like in screenshot below (you only have one server if your never use Developer Cloud Service Before):

![](./images/image54.png)

And check that Status changes to starting in your Fn template server:

![](./images/image55.png)

### Create New Project in DevCS
Now that you have created the environment connection to OCI and Build Machines, you must create a new project. This project will contain all the source code files in the GIT repository and the jobs and pipelines to CI/CD.

To create a new DevCS project click on Project Home menu and then click on +Create Button. Next introduce a representative name (ServerlessHOL for example) and optionally a Project Description. Select Private (Shared if you want your project accesible from external teams) and Preferred Language for the project. Then click Next button.

![](./images/devcs-projectcreation-newproject01.PNG)

Select Empty Project and Click Next button.

![](./images/devcs-projectcreation-newproject02.PNG)

Click Finish to create the new project.

![](./images/devcs-projectcreation-newproject03.PNG)

Wait to project environment creation (about 2 or 3 minutes)

![](./images/devcs-projectcreation-newproject04.PNG)

### Create GIT Repositories
You have now a new empty project created. Now we are going to create 3 GIT reporsitories, one for each serverless function.
To create a new GIT repo go to Project Home menu and click on Create Repository button. Next you write **fn_discount_upoload** as GIT name and optionally a Description. Then click Create button.

![](./images/devcs-project-create-git-repo01.PNG)

New GIT repo will be created with a README.md file only.

![](./images/devcs-project-create-git-repo02.PNG)

Repeat again to create 2 new GIT repos:
* **fn_discount_campaign**
* **fn_discount_cloudevents**
---
* [OPTIONAL] **fn_discount_campaign_pool**
---
Check that you have three GIT repositories in the main project menu.

![](./images/devcs-project-create-git-repo03.PNG)


## GIT Clone Repositories
Once you have created the GIT repositories in DevCS, now you must apply a GIT clone in your local serverless projects to sync local sources with DevCS GIT repo. Please follow next steps to clone your first git repo and repeat it with each serverless function.

Open your **fn_discount_upload** workspace in Vs code. File -> Open Workspace... and then select your workspace.

![](./images/fn-devcs-gitclone00.png)

Check that your entire serverless project was loaded in your IDE (vs code).

![](./images/fn-devcs-gitclone01.png)

Go to DevCS [ServerlessHOL] project, Repositories and click Clone button in the **fn_discount_upload** repository. Then click copy icon to copy the clone URL to the clipboard.

![](./images/fn-devcs-gitclone02.png)

Click Gear Icon at the botton of the IDE window and select Command Palette or it shotcut pressing ```CRTL+SHIFT+P```

![](./images/fn-devcs-gitclone03.png)

A new little window will be showed you at the top of the IDE window to run commands. Write ```git clone``` as command and press enter.

![](./images/fn-devcs-gitclone03b.png)

Paste the **fn_discount_upload** DevCS git URL previously copied to clipboard and press enter.

![](./images/fn-devcs-gitclone04.png)

A new windows will showed to you to select the local path to your local git project repository. Select [holserverless] directory and click Select Repository Location button.

![](./images/fn-devcs-gitclone05.png)

Now you could see a small popup window with the message that you will clone a git repository. But you must put your DevCS user password to finish the operation before. Introduce your password in the little popup window at the **TOP** of your IDE and press enter.

![](./images/fn-devcs-gitclone06.png)

After that, a new directory shoulbe created in your [holserverless] directory with the same name as your fn serverless project but finished in 1, like [fn_discount_upload-1].

![](./images/fn-devcs-gitclone07.png)

Access that new directory and show all hidden files and directories, because **.git** directory is hidden by default. Click in the hamburger icon and check Show Hidden Files.

![](./images/fn-devcs-gitclone07b.png)

Select **.git** directory and **README.md** file to copy them to your **fn_discount_upload** directory (without -1).

![](./images/fn-devcs-gitclone08.png)

You can click right mouse button and then copy or ```CTRL+C``` shortcut.

![](./images/fn-devcs-gitclone09.png)

Then Paste them to you **fn_discount_upload** directory.

![](./images/fn-devcs-gitclone10.png)

You must have all necessary files now to enable the SCRM (git) modules in your IDE.

![](./images/fn-devcs-gitclone11.png)

Now you can delete your temp clone directory **fn_discount_upload-1**

![](./images/fn-devcs-gitclone12.png)

Vs code do this process by default, so if you go to your Vs Code IDE windows, you should see a small icon number over Source Control icon. Click that icon to review your SCRM changes.

![](./images/fn-devcs-gitclone13.png)

In SCRM window you should have all the files with changes to review them and PUSH to your git repository in DevCS. As this is the first time you access your git repository all files are considered to have changes and will be created in your remote git repository in DevCS.


![](./images/fn-devcs-gitclone14.png)

Next you must click in the **commit** icon at the top of the SCRM menu.

![](./images/fn-devcs-gitclone15.png)

Next click Yes button to execute the commit.

![](./images/fn-devcs-gitclone16.png)

A new small popup appear at **TOP** of your IDE to write a dresciption for this commit change. Write a litte description like [fisrt commit] and press enter.

![](./images/fn-devcs-gitclone17.png)

Next click in the menu icon (tree point icon) and click Push to upload all changes to your remote git repository. 

![](./images/fn-devcs-gitclone18.png)

As you are using DevCS private git repo, you must introduce your password on each push. Please introduce your password and press enter.

![](./images/fn-devcs-gitclone19.png)

A new popup should be showed to you at the bottom of your IDE asking you if you want to perform a periodically run of ```git fetch``` command. Click No or Ask me later to continue.

![](./images/fn-devcs-gitclone20.png)

Now your code is stored in your remote private git repository in DevCS. Please check that all of your serverless function code is in that GIT repo. Go to DevCS project and GIT menu. Then Select your **fn_discount_upload.git** repository and check your code there.

![](./images/fn-devcs-gitclone21.png)

Repeat this process to the other two serverless functions. **fn_discount_cloud_events**

![](./images/fn-devcs-gitclone22.png)

And **fn_discount_campaign**

![](./images/fn-devcs-gitclone23.png)

Optionally **fn_discount_campaign_pool**

![](./images/fn-devcs-gitclone24.png)

## Developer Cloud Service CI/CD for Serverless. JOBS
Now you will create the appropiate job and pipelines to upload your functions to OCI FaaS. You'll use CI/CD pipelines from Developer Cloud Service. Please follow next steps to create your first group of jobs and pipelines and then repeat these steps in each fn serverless function.

Go to Developer Cloud Service Builds menu and Click Create Job button to create your first job.

![](./images/fn-devcs-jobs01.png)

Write a descriptive job name like [fn_discount_uoload] a job description and a Template (build machine template) VMFnTemplate.

![](./images/fn-devcs-jobs02.png)

Next Add Git configuration clicking in Add Git dropdown menu and then select Git.

![](./images/fn-devcs-jobs03.png)

In configure GIT menu, select your serverless function GIT repository [fn_discount_campaign_upload].

![](./images/fn-devcs-jobs04.png)

Next click in Paramters and Add Parameter. Then select String Parameter to create a new IN String parameter to your job script.

![](./images/fn-devcs-jobs05.png)

You should create 3 string parameters:

- **OCIR** with your ocir region URL and path, like [fra.ocir.io/<your_tenancy>/<your_ocir_repository>]
- **COMPARTMENTID** with your compartment oci id
- **SERVERLESSAPPNAME** with your FaaS OCI serverless app name like [gigis-serverless-hol]

![](./images/fn-devcs-jobs06.png)

Now you will create several steps in your job to build and deploy your function from your GIT repository files.
Click Steps menu and Add Step -> Docker -> Docker Login

![](./images/fn-devcs-jobs07.png)

- **Registry Host** is your regional OCI docker registry server, like [fra.oci.io] change [fra] for your [regional server info](https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab).
- **Username** to access your OCIR repository as [your_tenancy_namespace>/<your_username>]
- **Password** is your OCIR authtoken password created before for your user.

You could create a link to an external Docker Registry too. Click Link External Registry Button and write the appropiate data in the mandatory fields.

- **Registry Name** a descriptive name for your Docker Registry Link
- **Registry URL** is your regional OCI docker registry server, like [https://fra.oci.io] change [fra] for your [regional server info](https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab).
- **Authentication** slect Basic.
- **Username** to access your OCIR repository as [your_tenancy_namespace>/<your_username>]
- **Password** is your OCIR authtoken password created before for your user.

Then Click in Create Button and this registry link will be stored for future uses.

![](./images/fn-devcs-jobs08.png)

Let's create next job step. Now select Add Step -> OCI Cli. Write your OCI data in each field and select your OCI Region from the list.

![](./images/fn-devcs-jobs09.png)

Next you will create a new step. Select Add Step -> Fn -> Fn OCI

![](./images/fn-devcs-jobs10.png)

- **Ocracle Compartment ID** is your OCI ID compartment.
- **Provider** you must write [oracle]
- **Passphrase** you must write [''] (two simple quotes without spaces).

![](./images/fn-devcs-jobs11.png)

Now you could create a new job steps as Fn -> Fn Build and then Fn -> Fn Deploy but you will create a simple unix shell step using oci cli and fn cli.

Next Step to create -> **Unix Shell** changing the api-url (frankfurt) for your regions api-url (https://functions.**eu-frankfurt-1**.oraclecloud.com) and docker logout **fra**.ocir.io for your ocir region.

![](./images/fn-devcs-jobs12.png)

Then copy next code in your shell script text area:
```sh
fn list context
fn use context fncontext

fn update context oracle.compartment-id $COMPARTMENTID
fn update context api-url https://functions.eu-frankfurt-1.oraclecloud.com

fn update context registry $OCIR
fn --verbose deploy --app $SERVERLESSAPPNAME

fn use context default
fn list context

docker logout fra.ocir.io
```
![](./images/fn-devcs-jobs13.png)

Next you should create a new job that will be part of your function deployment pipeline. This job will clean your workspace if your main job is a faillure as result of a workspace or context errors. Click in Jobs -> New Job button. Write a descriptive name like [fn_clean_workspaces]. Write a job description and select your build machine template like [VMFnTemplate]

![](./images/fn-devcs-jobs14.png)

Create OCICli and Fn OCI steps as you create before (in the last job), but in the unix shell script copy next code:

```sh
fn use context default
fn list context
docker logout fra.ocir.io
```

![](./images/fn-devcs-jobs15.png)

These commands will put the context as default and will do a docker logout if your previous job fails before the docker logout completes.

Now you should have 2 jobs [fn_clean_workspaces] and [fn_discount_upload]

![](./images/fn-devcs-jobs16.png)

## Serverless app Pipelines
Let's create your first CI/CD serverless pipeline. Click Pipeline menu and Create Pipeline button. Next write a descriptive name as [gigispizza_FnCDUploadORDS] for example. Write a description and mark Auto start checkbox. Then click Create button to create your new pipeline.

![](./images/fn-devcs-jobs17.png)

Now you can see your pipeline draw area. In the right menu name Jobs you must have all your created jobs. Start process mark the first step in your pipeline.

![](./images/fn-devcs-jobs18.png)

Drag and drop your jobs to the drawing area.

![](./images/fn-devcs-jobs19.png)

Connect Start with fn_discount_upload job, clicking in the start small circle and point the fn_discount_upload right small circle.

![](./images/fn-devcs-jobs20.png)

Same from fn_discount_upload to fn_clean_workspaces, but after arrow creation you have to right mouse button click over the new arrow and select Failed in the combobox Result Condition. This step in your pipeline only will be fired if your fn_discount_upload job result in a faillure.

![](./images/fn-devcs-jobs21.png)

After pipeline configuration click in Save Button. You'll see your new pipeline.

![](./images/fn-devcs-jobs22.png)

To create the other serverless functions pipelines, you will repeat last steps, but you can create the jobs copying from existing jobs previously created. You have to click in Jobs menu -> Create Job again

![](./images/fn-devcs-jobs23.png)

Write a descriptive name for the new job like [fn_discount_campaign_cloud_events]. Write a description for the job and then check Copy From Existing and then select the previously created job from witch you want to create a copy [fn_discount_upload]. Select the build machine template for the job like [VMFnTemplate] and click Create button.

![](./images/fn-devcs-jobs24.png)

A new job, copy from fn_discount_upload might be created and now you could change the appropiate values to configure the new job to the cloud_events function. Click Git menu and select [fn_discount_cloud_events.git] as the job GIT repository. Other values or scripts are the same, so you don't have to change anything else.

![](./images/fn-devcs-jobs25.png)

Let's create the pipeline. Click Pipeline menu and Create Pipeline button to access to the pipeline drawing area and repeat the same procedure to create the fn_discount_cloud_events pipeline that you use to create the upload pipeline. The fn_clean_workspaces job is shared across all functions, you don't have to create it again, just use it.

![](./images/fn-devcs-jobs26.png)

Repaet the same steps to create **fn_discout_campaign** jobs and pipeline. Create the job copying it from existing job.

![](./images/fn-devcs-jobs27.png)

Select the **fn_discount_campaign** GIT repository as GIT repository for you new Job.

![](./images/fn-devcs-jobs28.png)

Create the pipeline

![](./images/fn-devcs-jobs29.png)

Optionally you could create the same jobs and pipelines for **[fn_discount_campaign_pool]**.

Now you have 3 serverless function pipelines. 

![](./images/fn-devcs-jobs30.png)

### Lauch pipelines manually
When you change your function code you have not to write any fn command in your command line to build and upload the new code. Just **push** your new changes to your GIT repository and then click Play button in your pipeline to lauch the build and deploy process.

![](./images/fn-devcs-jobs31.png)

You should see a popup window with the pipeline parameters and its default value.

![](./images/fn-devcs-jobs32.png)

Click Build Now Button and review the Build Queue.

### Lauch pipelines automatically
You can lauch your CI/CD pipelines automatically, every time you push your changes to your GIT repository. To fire your pipeline automatically you have to enable this process in your pipeline configuration.

![](./images/fn-devcs-jobs30.png)

Click in your first pipeline job [fn_discount_campaign] for example.

![](./images/fn-devcs-jobs40.png)

Then click in Configure Button. Next check **Automatically perform build on SCM commit**. When you anable this check, every time you do a new commit and push into the GIT repository, this job will be fired automatically. The other jobs in the pipeline will be fired or not dependeing on the result of this first job execution.

![](./images/fn-devcs-jobs41.png)

You can test you pipeline changing you code in your IDE developer app and then you commit the changes and push them to your GIT repository. Review the Build Queue in Developer Cloud Services -> Builds.

### Review your functions after CI/CD
The pipeline jobs are waiting for Executor (Build) machine availability.

![](./images/fn-devcs-jobs33.png)

When one Build VM is available first job in the pipeline will be assigned to that build machine to execute its steps.

![](./images/fn-devcs-jobs34.png)

You can review the pipeline status. Click in the pipeline name to review the jobs status. When a job is finished successfully the job progress will be green, if a faillure ocurred then the job progress will be red. In your pipelines the second job only will be fired when the first job is red.

![](./images/fn-devcs-jobs35.png)

You can review the the job status. Click in the job name and review the job results.

![](./images/fn-devcs-jobs36.png)

You can review the build log. Click in Build Log button to review the job log. For example in your job log you should see the function build process with your function version number and pushing it to your OCIR repository.

![](./images/fn-devcs-jobs37.png)

Next go to your FaaS menu in OCI web (Developer Services -> Functions) and review your functions **Created** and **Last updated** dates.

![](./images/fn-devcs-jobs38.png)

You can review too your OCIR repository in OCI (Developer Services -> Registry). You must have a docker image repository with your OCIR path and your serverless function docker images.

![](./images/fn-devcs-jobs39.png)

### Return main Gigis Hands on Labs page.
* [Gigi's HOL](https://github.com/oraclespainpresales/GigisPizzaHOL)