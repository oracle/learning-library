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

Full code example

```
import torch
import torchvision
import torchvision.transforms as transforms
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

transform = transforms.Compose(
    [transforms.ToTensor(),
     transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])

trainset = torchvision.datasets.CIFAR10(root='./data', train=True,
                                        download=True, transform=transform)
trainloader = torch.utils.data.DataLoader(trainset, batch_size=4,
                                          shuffle=True, num_workers=2)

testset = torchvision.datasets.CIFAR10(root='./data', train=False,
                                       download=True, transform=transform)
testloader = torch.utils.data.DataLoader(testset, batch_size=4,
                                         shuffle=False, num_workers=2)

classes = ('plane', 'car', 'bird', 'cat',
           'deer', 'dog', 'frog', 'horse', 'ship', 'truck')

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(3, 6, 5)
        self.pool = nn.MaxPool2d(2, 2)
        self.conv2 = nn.Conv2d(6, 16, 5)
        self.fc1 = nn.Linear(16 * 5 * 5, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        x = x.view(-1, 16 * 5 * 5)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x


net = Net()
net.to(device)

criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9)

for epoch in range(2):  # loop over the dataset multiple times

    running_loss = 0.0
    for i, data in enumerate(trainloader, 0):
        # get the inputs; data is a list of [inputs, labels]
        inputs, labels = data[0].to(device), data[1].to(device)

        # zero the parameter gradients
        optimizer.zero_grad()

        # forward + backward + optimize
        outputs = net(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()

        # print statistics
        running_loss += loss.item()
        if i % 2000 == 1999:    # print every 2000 mini-batches
            print('[%d, %5d] loss: %.3f' %
                  (epoch + 1, i + 1, running_loss / 2000))
            running_loss = 0.0

print('Finished Training')

PATH = './cifar_net.pth'
torch.save(net.state_dict(), PATH)

net = Net()
net.load_state_dict(torch.load(PATH))

correct = 0
total = 0
with torch.no_grad():
    for data in testloader:
        images, labels = data
        outputs = net(images)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print('Accuracy of the network on the 10000 test images: %d %%' % (
    100 * correct / total))

class_correct = list(0. for i in range(10))
class_total = list(0. for i in range(10))
with torch.no_grad():
    for data in testloader:
        images, labels = data
        outputs = net(images)
        _, predicted = torch.max(outputs, 1)
        c = (predicted == labels).squeeze()
        for i in range(4):
            label = labels[i]
            class_correct[label] += c[i].item()
            class_total[label] += 1


for i in range(10):
    print('Accuracy of %5s : %2d %%' % (
        classes[i], 100 * class_correct[i] / class_total[i]))
```


***NOTE:*** When running this specific example, you may not see a significant decrease in the training time. This example is designed to keep things simple, so the goal is to just make sure that the code executes properly. The issue is that the images and the model are small. Increasing the number of layers and channels in the model as well as increasing the `batch_size` in the dataloader will start to show differences in the execution time when comparing CPUs to GPUs.

## Acknowledgements
* **Author** - Justin Blau, Senior Solutions Architect, Big Compute
* **Last Updated By/Date** - Justin Blau, Big Compute, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
