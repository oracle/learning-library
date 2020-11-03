# Utilizing a GPU
## Introduction

The last topic to cover relates to computational optimization using GPUs. At the end of the tutorial, after saving the model and testing its accuracy, the current code is using only CPU resources. By slightly modifying the code, we can use GPU resources. Oracle Cloud Infrastructure provides an array of NVIDIA GPUs with different shapes depending on the computational workload required. To get started, I recommend running this code on a VM.GPU2.1. After finding the appropriate GPU location, likely `cuda:0`, the model, batched data and labels can be sent to the device for processing using `.to(device)` methods. PyTorch wraps all the memory transition code in these methods so that you don’t have to worry about properly assigning GPU memory.

Estimated Lab Time:  5 minutes

### Objectives
In this lab, you will learn about:
* Training on a GPU

### Prerequisites

This lab assumes you have:
- Completed the previous labs
- Have a GPU-enabled instance

## **STEP 1**: Enabling GPU Acceleration

1. After the imports, add this line of code:

    ```python
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    ```

2. This line of code will set the device for the torch framework based on what is available on the system. The in-line if-statement allows the code to execute even if a GPU is not available as it defaults the value back to `cpu`. After line 45 in the provided complete code, after `net` is instantiated, move the `net` model to the GPU by running this line of code.

    ```python
    net.to(device)
    ```

3. Finally, during the training we need to move the batched data over to the GPU for processing. Replace line 55 in the provided code with this line.

    ```python
    inputs, labels = data[0].to(device), data[1].to(device)
    ```

`data[0]` contains the batched images, and `data[1]` contains the matching labels. All of those values are sent over to the GPU with `.to(device)`. That's it! PyTorch makes it easy to enable the GPU with declarative syntax.

[Click here to download the full code example](https://objectstorage.us-ashburn-1.oraclecloud.com/p/UudtANEChREpKXDjzRvqRzNPhPJpTEMfq5BHf6Ym7H12zSE8wGcTtwabHyxpcpow/n/c4u03/b/ai-ml-library/o/jblau-image-classification-pytorch.zip)


***NOTE:*** When running this specific example, you may not see a significant decrease in the training time. This example is designed to keep things simple, so the goal is to just make sure that the code executes properly. The issue is that the images and the model are small. Increasing the number of layers and channels in the model as well as increasing the `batch_size` in the dataloader will start to show differences in the execution time when comparing CPUs to GPUs.

## Acknowledgements
* **Author** - Justin Blau, Senior Solutions Architect, Big Compute
* **Last Updated By/Date** - Justin Blau, Big Compute, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.