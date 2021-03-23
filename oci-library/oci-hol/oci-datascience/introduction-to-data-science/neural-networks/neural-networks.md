# Lab: Neural Networks (using OCI Data Science service)

## Introduction

In this lab we will build a Neural Network to recognize handwritten digits. We will cover the required theory behind Neural Networks first, after which you will go on and put the theory into practice using the OCI Data Science service.

Estimated lab time: 60 minutes (video 30 minutes, exercise +/- 30 minutes)

This video will cover the theory behind Neural Networks.

[](youtube:jp5QVjbJbOo)

### Objectives

In this lab you will:
* Learn the theory behind Neural Networks.
* Learn how to prepare data for a NN.
* Learn the basics of constructing a Neural Network with Keras and Tensorflow.
* Learn how to visualize images with the matlib library.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account (see prerequisites in workshop menu)
* OCI Data Science service with dependencies (see previous lab)

## **STEP 1:** Understanding the dataset and the architecture of the model

1. Understanding the dataset

   We will use the MNIST (Modified National Institute of Standards and Technology database) dataset for this, a real classic in Machine Learning. This dataset consists of thousands of images, each image representing a handwritten digit. All images have been labelled with the corresponding digit.

   ![digit labels](images/labeled.png)

2. Understanding the architecture

   Have a look at the architecture that we will build.

   * `Input layer`: Our NN must be able to process one image in its input layer at a time. As you know, an image is 2D (in our case 28x28 pixels), but a basic NN input layer is flat (1D). Therefore, we will convert the 2D image into a long 1D array (28*28=784 input neurons).
   * We will have 2 hidden layers of 16 neurons each. The number of hidden layers and the number of neurons are somewhat arbitrary, and you may want to experiment with these.
   * `Output layer`: This will have 10 neurons. Each neuron will represent the output for one of the digits (0 to 9).

   ![NN Architecture](images/nnarchitecture.png)

## **STEP 2:** Install additional Python library idx2numpy

   In this lab we will require a Python library that by default is not installed in Data Science, called `"idx2numpy"`. The source images are in IDX format, but we need a native array format for our Neural Network. This library takes care of the conversion from IDX to native array format.

   1. Open terminal

   This is basically your OS access.

![Notebook Terminal](images/newterminal.png)

2. Install the new library

   PIP is a command line tool to install Python packages. Copy the following command into the terminal.

    ```bash
    <copy>
    pip install idx2numpy
    </copy>
    ```

## **STEP 3:** Downloading and unpacking the data

1. Create a new Jupyter notebook.

   ![create jupyter notebook](images/createjupyternotebook.png)

2. Download the MNIST data

    ```bash
    <copy>
    !wget http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
    !wget http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
    !wget http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
    !wget http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz
    </copy>
    ```

3. Unzip

   This will make all the files available in your root folder in the Data Science notebook.

    ```bash
    <copy>
    !gunzip train-images-idx3-ubyte.gz
    !gunzip train-labels-idx1-ubyte.gz
    !gunzip t10k-images-idx3-ubyte.gz
    !gunzip t10k-labels-idx1-ubyte.gz
    </copy>
    ```

## **STEP 4:** Data Access and Exploration

1. Load the data into memory

   Every time you see a piece of code as the following, please paste it into the notebook and click the run icon.

   ![run script](images/runscript.png)

    ```python
    <copy>
    %matplotlib inline
    import idx2numpy
    import numpy as np
    trainfile = 'train-images-idx3-ubyte'
    trainfilelabels = 'train-labels-idx1-ubyte'
    testfile = 't10k-images-idx3-ubyte'
    testfilelabels = 't10k-labels-idx1-ubyte'
    x_train = idx2numpy.convert_from_file(trainfile)
    y_train = idx2numpy.convert_from_file(trainfilelabels)
    x_test = idx2numpy.convert_from_file(testfile)
    y_test = idx2numpy.convert_from_file(testfilelabels)
    </copy>
    ```

2. Inspect the datasets

   In the previous lab we had to split the data into train and test ourselves. Notice that in this lab the split has already been done for us.

   `x_train` are the images. You could see every pixel as an input feature.
   `y_train` are the labels of the image. This is a one-dimensional array with the digits as assigned by a person (0 to 9).

   Equally, `x_train` and `y_train` are the images and corresponding labels for the test set.  

3. Verify the data

   How many images do we have for training, and what is the size of each image?

   The following shows that the training data set has `60000` images. The other values indicate the dimensions of the image: 28x28 pixels.

    ```python
    <copy>
    x_train.shape
    </copy>
    ```

4. What is the shape of the labels for training?

   The following shows that we have a list of 60000 entries. Each entry indicates the digit for the image (a value from 0 to 9).

    ```python
    <copy>
    y_train.shape
    </copy>
    ```

5. Let's do the same for the test images.

   This will tell us that there are 10000 images for validation.

    ```python
    <copy>
    x_test.shape
    </copy>
    ```

6. And let's doublecheck the labels of the test images.

   This will show that the images are labeled with the corresponding digit.

    ```python
    <copy>
    y_test.shape
    </copy>
    ```

7. How does one particular image actually look like?

   Let's display one of the training images at random, in this case the one with index 5 (of 60000).

   You can more or less see a shape of a digit show up. We'll show it as an actual image a bit later on.

    ```python
    <copy>
    x_train[5]
    </copy>
    ```

8. What is the label for this particular image?

   Let's show the label by accessing the y_train with the same index (5).

   According to the labels, this is an image of the digit 2.

    ```python
    <copy>
    y_train[5]
    </copy>
    ```

9. Display the data as an image

  Let's verify this by displaying the data as an image. We will use the matplotlib library to do so.

    ```python
    <copy>
    import matplotlib.pyplot as plt
    plt.imshow(x_train[5], cmap='Greys')
    </copy>
    ```

  Indeed, we can see that this is a two.

## **STEP 5:** Data Preparation

   The Neural Network that we want to build will have an input layer of 784 neurons. See also the architecture picture above. Each of the neurons will represent one pixel in the input image.

   There are two issues that we have to address:
   * `The shape`: We must convert the 2D shape of 28x28x1 pixels into a 1D array of 784 elements.
   * `The values`: Our input neurons expect values between `0.0` and `1.0`, however our actual input values are currently `0` to `255`. We must scale these values as well.

1. Flatten the 28x28 array

   Flatten the array of each image into a 784 array. Do this for train and test.

    ```python
    <copy>
    x_train = x_train.reshape(x_train.shape[0], 784)
    x_test = x_test.reshape(x_test.shape[0], 784)
    </copy>
    ```

2. Check the results

   Let's check that this conversion was successful by checking the new shape of the training set.

    ```python
    <copy>
    x_train.shape
    </copy>
    ```

3. Scale the values of the pixels from 0-255 to 0.0-1.0.

    ```python
    <copy>
    x_train = x_train.astype('float32')
    x_test = x_test.astype('float32')
    x_train /= 255
    x_test /= 255
    </copy>
    ```

4. Check the results

Let's check the result by again displaying our example digit at index 5.

You will see that there are no rows anymore in the array (it's 1D now), and that the values are between 0.0 and 1.0.

    ```python
    <copy>
    x_train[5]
    </copy>
    ```

## **STEP 6:** Model build and training

1. Doublecheck the shapes

   Let's doublecheck the shapes of the input data before we start the training process.

   You should see `x_train shape: (60000, 784)`, Number of images in x_train 60000, Number of images in x_test 10000.

    ```python
    <copy>
    print('x_train shape:', x_train.shape)
    print('Number of images in x_train', x_train.shape[0])
    print('Number of images in x_test', x_test.shape[0])
    </copy>
    ```

2. Construct the model

   Our data is ready to go. Now it's time to build the neural network. Remember, we will build an input layer of 784 neurons, then two hidden layers of 16 neurons each, and finally an output layer of 10 neurons (one for each digit). If this is unclear, please review the architecture at the start of the lab. We are using the Tensorflow and Keras open source libraries for this.

   Notice that there is no clear methodology that can tell you from the beggining what the right size and number of hidden layers would be required. To be able to determine this parameters you would need to "debug" the neural network. Change the number of hidden layers or the size of the neurons and monitor if the loss gets lower and the accuracy increases. Later validate this on the test set.

   Notice how in the first `model.add` we have to specify both the input shape (784 neurons) and the first hidden layer (16 neurons).

    ```python
    <copy>
    import tensorflow as tf
    from keras.models import Sequential
    from keras.layers import Dense
    model = Sequential()
    model.add(Dense(16, input_shape=(784, ), activation=tf.nn.relu))
    model.add(Dense(16, activation=tf.nn.relu))
    model.add(Dense(10, activation=tf.nn.softmax))
    </copy>
    ```

3. Train the model

   At this point the initial architecture of our Neural Network is ready. It has random weights to start with. Next, we will train the model to optimize the weights.

   Depending on the shape you are running the notebook on, this can take a few minutes.

   Notice that the input for the model training is the training images (`x_train`) and the training labels (`y_train`). We have chosen `10 epochs`. This means the neural network would run through the entire dataset 10 times.

   * `loss` specifies the loss or also called the objective function. It calculates how far off the neural network's predictions are. The results are used to adjust the weights to minimize the loss.
   * `optimizer` is a function used to minimize the loss. To do so we need to adjust the waits in the forward and the backpropagation. The optimizer is the function that would be used in that process.
   * `metrics` is a function that is used to judge the performance of the model. You can specify one or more metrics. It is similar to the loss function but the result is not used when training the model. You could use as metric any of the loss functions available in Keras.

    ```python
    <copy>
    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])
    model.fit(x=x_train, y=y_train, epochs=10)
    </copy>
    ```

## **STEP 7:** Check model accuracy

1. Check the accuracy of the last epoch.

   You should see an accuracy of around 96%. This is the accuracy on the data in the `training` set. However, as you know by now, it's important to verify the accuracy of the model on `unseen` data.

   ![NN accuracy](images/nnaccuracy.png)

2. Visual verification of the model by predicting an example

   First of all, let's check the performance intuitively through a visualization. Let's take an example image from the test set and check if the model is able to classify it correctly. We'll take a random index of 99.

   You will see this is a 9.

    ```python
    <copy>
    plt.imshow(x_test[99].reshape(28, 28),cmap='Greys')
    </copy>
    ```

3. What is the official label for this digit?

   You will see this is labelled as a 9 as well.

    ```python
    <copy>
    y_test[99]
    </copy>
    ```

4. Is our model able to correctly classify it as a 9?

   The argmax function returns the output neuron that has the highest value. In this case this correctly predicts a 9.

    ```python
    <copy>
    predict = model.predict(x_test[99].reshape(1,784))
    print(predict.argmax())
    </copy>
    ```

5. Numerical verification of the model

  We can use model.evaluate to calculate the accuracy of prediction on the entire testset. This will run the prediction on the 10000 images in the testset and compare the predicted digits with the actual labels, and calculate an accuracy.

    ```python
    <copy>
    model.evaluate(x_test, y_test)
    </copy>
    ```

6. Conclusion of numerical verification

   You should see an accuracy on unseen data of about 95%.
   ![nn actual accuraty](images/nnactualaccuracy.png)

   This is the actual accuracy of the model. In other words, the model is able to interpret an image of a digit and correctly classify it in 95% of the cases.

Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors** - Jeroen Kloosterman - Product Strategy Manager - Oracle Digital, Lyudmil Pelov - Consulting Solution Architect - A-Team Cloud Solution Architects, Fredrick Bergstrand - Sales Engineer Analytics - Oracle Digital, Hans Viehmann - Group Manager - Spatial and Graph Product Management
* **Last Updated By/Date** - Jeroen Kloosterman, Oracle Digital, Jan 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
