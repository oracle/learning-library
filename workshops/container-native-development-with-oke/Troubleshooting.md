# Troubleshooting

## OCI Capacity

- If Terraform or Helm is unable to instantiate a compute image or a load balancer, the cause could be a service limit being exceeded in the OCI tenancy. Check the OCI console (Compute->Instances and Networking->Load Balancers) to ensure that no extra OCI components are running. If an environment needs to be deleted/cleaned and re-created, ensure after deletion that all compute instances and load balancers are in fact in the 'terminated' state in the OCI console before trying to re-create.

- Example Service Limit Error from Terraform:

  oci_core_instance.TFInstanceK8sWorker: Status: 400; Code: LimitExceeded; OPC Request ID: /223E8390CDF939FF37388D4B02B53BDC/7F5A810FFAA8D556E5A16B08270E7A25; Message: You have reached your service limit of 1 in this Availability Domain for VM.Standard1.1. Please try launching the instance in a different Availability Domain or Region, or try using a different shape. If you have reached all Service limits, please contact Oracle support to request a limit increase.


## Kubectl Errors

- Kubectl needs to have a **KUBECONFIG** environment variable configured that contains the path to the correct `kubeconfig` file for the cluster. If `kubectl proxy` or other `kubectl` commands do not work, ensure that the current shell has the **KUBECONFIG** environment variable set using `echo $KUBECONFIG`. This may need to be reset for each new terminal window opened if bashrc/bash_profile is not modified. If the path looks correct, check which cluster kubectl is trying to reach by running `kubectl cluster-info`. The IP address of the cluster returned by this command should match the public IP of the **lb-k8smaster** load balancer, which can be found on in the OCI Console under **Networking->Load Balancers** in the **Demo** compartment.

- Kubectl may be pointing to the correct cluster, but dashboard may not load in browser. Check that the correct dashboard URL is being used (from the links in the lab guide, not http://localhost:8001/ui). Next, check that there are no load balancers (Networking->Load Balancers) or compute instances (Compute) that are in a red **FAILED** state, or in a yellow **PROVISIONING** state for an extended period of time. If there are, delete the infrastructure with `terraform destroy` and reprovision it with `terraform apply`. It is possible that you will need to delete/terminate an instance or load balancer using the OCI console if terraform is unable to remove it.


## YAML Errors

- Two YAML files are critical to the workshop -- `wercker.yml` and `kubernetes.yml.template`, both found in the **twitter-feed** GitHub repository. If wercker pipelines are failing, check the formatting and completeness of these YAML files.

  - One common issue is missing indentation. In YAML files, indentation is the only way that parent/child relationships are identified. Ensure that the indentation in both files matches the lab guide's relevant code snippet and screenshot (generally, check wercker.yml for errors shown in wercker, and kubernetes.yml.template for errors shown in kubernetes). Proper indentation is two spaces for each level.

  - Another possible issue is missing lines in the YAML file, such as the `steps:` header between the name of a pipeline and its commands. This is likely if the YAML was typed by hand instead of copied and pasted into GitHub.

  - A third potential issue with YAML files is also related to indentation. In this case, a child is indented either too much or too little, so that it lines up under wrong parent. This will produce valid YAML, but not be syntactically correct. The most common place this happens is in lab 400, step 1. `volumeMounts` should be indented two spaces farther than `volumes` for the file to be correct.

## Environment Variables

- Wercker environment variables are important for every pipeline that gets run in the labs. Several common problems may arise:

  - Environment variables can be assigned to an individual pipeline, or to the application as a whole. All environment variables in this workshop should be assigned to the **application**, not to a pipeline. This is because they are reused in various pipelines. Check that the main Environment tab in Wercker (at the same level as Runs and Workflows) lists all required environment variables.

  - Environment variables are case sensitive, and for this workshop they keys should always be in **ALL CAPS**.

  - Check that there are no typos in the keys and values, such as a misspelling of KUBERNETES or any whitespace before or after the text.

## Incorrect OCI Compartment Used

- This issue is common in GSE environments. If compartments other than **Demo** exist in the the tenant, ensure that the **Demo** compartment OCID has been specified in the `terraform.tfvars` file. If another compartment has been specified, terraform will encounter errors when provisioning resources because the GSE user account only has permissions to work in the Demo compartment. This will look like an HTTP 4XX error in the terraform output.
