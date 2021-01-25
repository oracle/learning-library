# Build a Convolutional Neural Network in TensorFlow to Classify Traffic Sign Images

## Introduction

In this lab you will learn how to build a convolutional neural network (CNN) in TensorFlow, running on Oracle Cloud Infrastructure GPU compute instances, to classify traffic sign images from the German Traffic Sign Dataset.

This lab draws heavily on code and text by [Andrea Palazzi](https://www.linkedin.com/in/andreapalazzi/), used with permission, from his [Udacity Nanodegree Projects](https://udacity.com) and his [Github Repository](https://github.com/ndrplzself-driving-car). There is no warranty associated with this code from the original developer or Oracle.

**Estimated Lab Time: 2 hours**

### Objectives

As a Data Scientist, Data Engineer, Power User or Developer, expand your knowledge on the following topics:

- Dataset Exploration and Visualization
- Data Augmentation
- Deep Network Design and Training
- Visualization of the Certainty and Uncertainty of the Model's Predictions

### Prerequisites

- Familiarity with data science is helpful
- Familiarity with convolutional neural networks is helpful
- Familiarty with data modeling is helpful
 
### **Please Note**: This Jupyter notebook provides a template for you to implement your functionality in stages, which is required to successfully complete this project. If additional code is required that cannot be included in the notebook, be sure that the Python code is successfully imported and included in your submission, if necessary. Sections that begin with "Implementation" in the header indicate where you should begin your implementation for your project. Note that some sections of implementation are optional and are marked with "Optional" in the header.

## **STEP 1: Load the Data**

1. Import pickle and load the traffic data   

  ```
  <copy>import pickle
  def load_traffic_sign_data(training_file, testing_file):
    with open(training_file, mode='rb') as f:
        train = pickle.load(f)
    with open(testing_file, mode='rb') as f:
        test = pickle.load(f)
    return train, test</copy>
```
2. Load pickled data
```
<copy>train, test = load_traffic_sign_data('../traffic_signs_data/train.p',
'../traffic_signs_data/test.p')

X_train, y_train = train['features'], train['labels']
X_test, y_test = test['features'], test['labels']</copy>
```
## **STEP 2: Dataset Summary and Exploration**

1. The pickled data is a dictionary with four key/value pairs.
    * 'features' is a 4D array containing raw pixel data of the traffic sign images (num examples, width,
    height, channels).
    * 'labels' is a 2D array containing the label/class id of the traffic sign. The signnames.csv file contains id -> name mappings for each id.
    * 'sizes' is a list containing tuples (width, height) representing the original width and height of the
    image.
    * 'coords' is a list containing tuples (x1, y1, x2, y2) representing coordinates of a bounding box around
    the sign in the image. These coordinates assume the original image. The pickled data contains resized
    versions (32 by 32) of these images.

2. Complete the basic data summary below.
    ```
  <copy>import numpy as np</copy>
    ```
  Number of examples:
    ```
  <copy>n_train, n_test = X_train.shape[0], X_test.shape[0]</copy>
    ```
  What's the shape of an traffic sign image? 
    ```
  <copy>image_shape = X_train[0].shape</copy>
    ```
  How many classes?
    ```
  <copy>n_classes = np.unique(y_train).shape[0]
  print("Number of training examples =", n_train)
  print("Number of testing examples =", n_test)
  print("Image data shape =", image_shape)
  print("Number of classes =", n_classes)</copy>
  
  #Output
  Number of training examples = 39209
  Number of testing examples = 12630
  Image data shape = (32, 32, 3)
  Number of classes = 43
    ```
3. Visualize the German Traffic Signs Dataset by using the pickled files. First, we must import matplotlib.
  ```
  <copy>import matplotlib.pyplot as plt
  %matplotlib inline</copy>
  ```
4. Show a random sample from each class of the traffic sign dataset 
  ```
<copy>rows, cols = 4, 12
fig, ax_array = plt.subplots(rows, cols)
plt.suptitle('RANDOM SAMPLES FROM TRAINING SET (one for each class)')
for class_idx, ax in enumerate(ax_array.ravel()):
    if class_idx < n_classes:
        # show a random image of the current class #
        cur_X = X_train[y_train == class_idx]
        cur_img = cur_X[np.random.randint(len(cur_X))]
        ax.imshow(cur_img)
        ax.set_title('{:02d}'.format(class_idx))
    else:
        ax.axis('off')</copy>
  ```
  ```
#hide both x and y ticks
<copy>plt.setp([a.get_xticklabels() for a in ax_array.ravel()], visible=False)
plt.setp([a.get_yticklabels() for a in ax_array.ravel()], visible=False)
plt.draw()</copy>
  ``` 
5. We can also get the idea of how these classes are distributed in both training and testing set.
    ```
    # bar-chart of classes distribution
    <copy>train_distribution, test_distribution = np.zeros(n_classes), np.zeros(n_classes)
    for c in range(n_classes):
        train_distribution[c] = np.sum(y_train == c) / n_train
        test_distribution[c] = np.sum(y_test == c) / n_test
    fig, ax = plt.subplots()
    col_width = 0.5
    bar_train = ax.bar(np.arange(n_classes), train_distribution, width=col_width, color='r')
    bar_test = ax.bar(np.arange(n_classes)+col_width, test_distribution, width=col_width,
    color='b')
    ax.set_ylabel('PERCENTAGE OF PRESENCE')
    ax.set_xlabel('CLASS LABEL')
    ax.set_title('Classes distribution in traffic-sign dataset')
    ax.set_xticks(np.arange(0, n_classes, 5)+col_width)
    ax.set_xticklabels(['{:02d}'.format(c) for c in range(0, n_classes, 5)])
    ax.legend((bar_train[0], bar_test[0]), ('train set', 'test set'))
    plt.show()</copy>
    ```

6. From the plot you created above, you can notice that there is a strong imbalance among the classes. Indeed, some classes are relatively overrepresented, while others are much less common. However, the data distribution is almost the same between the training and testing set. This is good news as we shouldn't have a problem related to dataset shift when evaluating our model on the test data.

## **STEP 3: Design and Test a Model Architecture**

1. Design and implement a deep-learning model that learns how to recognize traffic signs. Train and test your model on the [German Traffic Sign Dataset](http://benchmark.ini.rub.de/?section=gtsrb&subsection=dataset). When thinking about this problem, consider the follow aspects:

      - Neural network architecture
      - Preprocessing techniques (normalization, RGB to grayscale, and so on)
      - Number of examples per label (some have more than others)
      - Generating fake data

2.  Implementation - Use the code cell to implement the first step of your project. After you've completed your implementation and are satisfied with the results, be sure to thoroughly answer the questions that follow.

    ```
  # Feature Processing
  <copy>import cv2
  def preprocess_features(X, equalize_hist=True):
      # convert from RGB to YUV
      X = np.array([np.expand_dims(cv2.cvtColor(rgb_img, cv2.COLOR_RGB2YUV)[:, :, 0], 2) for rgb_img in X])
              
      # adjust image contrast
      if equalize_hist:
          X = np.array([np.expand_dims(cv2.equalizeHist(np.uint8(img)), 2) for img in X])
      
      X = np.float32(X)
      
      # standardize features
      X -= np.mean(X, axis=0)
      X /= (np.std(X, axis=0) + np.finfo('float32').eps)
      
      return X

  X_train_norm = preprocess_features(X_train)
  X_test_norm = preprocess_features(X_test)</copy>
    ```

3.  Following this [paper by Sermanet and LeCun](http://yann.lecun.com/exdb/publis/pdf/sermanet-ijcnn-11.pdf), we've employed the following steps of feature preprocessing:
   - **Each image is converted from RGB to YUV color space, then only the Y channel is used**. This choice leads to the best performing model. It enables us to distinguish all the traffic signs just by looking at the grayscale image.
   - **The contrast of each image is adjusted by means of histogram equalization**. This mitigates the numerous situations in which the image contrast is poor.
   - **Each image is centered on zero mean and divided for its standard deviation**. This feature scaling has beneficial effects on the gradient descent performed by the optimizer.
    ```
    <copy>from sklearn.model_selection import train_test_split
    from keras.preprocessing.image import ImageDataGenerator

    # split into train and validation
    VAL_RATIO = 0.2

    X_train_norm, X_val_norm, y_train, y_val = train_test_split(X_train_norm, y_train,
    test_size=VAL_RATIO, random_state=0)</copy>
    ```

    ```
    # create the generator to perform online data augmentation
    <copy>image_datagen = ImageDataGenerator(rotation_range=15.,
      zoom_range=0.2,
      width_shift_range=0.1,
      height_shift_range=0.1)</copy>
    ```
    
    ```
    # take a random image from the training set
    <copy>img_rgb = X_train[0]</copy>
    ```

    ```
    # plot the original image
    <copy>plt.figure(figsize=(1,1))
    plt.imshow(img_rgb)
    plt.title('Example of RGB image (class = {})'.format(y_train[0]))
    plt.show()</copy>

    ```

    ```
    # plot some randomly augmented images
    <copy>rows, cols = 4, 10
    fig, ax_array = plt.subplots(rows, cols)
    for ax in ax_array.ravel():
      augmented_img, _ = image_datagen.flow(np.expand_dims(img_rgb, 0), y_train[0:1]).next()
      ax.imshow(np.uint8(np.squeeze(augmented_img)))
    plt.setp([a.get_xticklabels() for a in ax_array.ravel()], visible=False)
    plt.setp([a.get_yticklabels() for a in ax_array.ravel()], visible=False)
    plt.suptitle('Random examples of data augmentation (starting from the previous image)')
    plt.show()</copy>
    
    Using TensorFlow backend.    
    ```

4. Next comes setting up training, validation, and testing data for the model. For the train and test split, we used the ones provided, composed by the 39209 and 12630 examples, respectively. To get additional data, we leveraged the **ImageDataGenerator** class provided in the [Keras Library](https://keras.io/api/preprocessing/image/). By doing so, we could perform data augmentation online, during the training. Training images are randomly rotated, zoomed, and shifted, but just in a narrow range, to create some variety in the data while not completely twisting the original feature content.

    ```
    <copy>import tensorflow as tf
    from tensorflow.contrib.layers import flatten

    def weight_variable(shape, mu=0, sigma=0.1):
      initialization = tf.truncated_normal(shape=shape, mean=mu, stddev=sigma)
      return tf.Variable(initialization)

    def bias_variable(shape, start_val=0.1):
      initialization = tf.constant(start_val, shape=shape)
      return tf.Variable(initialization)

    def conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME'):
      return tf.nn.conv2d(input=x, filter=W, strides=strides, padding=padding)

    def max_pool_2x2(x):
      return tf.nn.max_pool(value=x, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding='SAME')</copy>
    ```

    ```
    # network architecture definition
    <copy>def my_net(x, n_classes):
      c1_out = 64
      conv1_W = weight_variable(shape=(3, 3, 1, c1_out))
      conv1_b = bias_variable(shape=(c1_out,))
      conv1 = tf.nn.relu(conv2d(x, conv1_W) + conv1_b)
      pool1 = max_pool_2x2(conv1)
      drop1 = tf.nn.dropout(pool1, keep_prob=keep_prob)
      c2_out = 128
      conv2_W = weight_variable(shape=(3, 3, c1_out, c2_out))
      conv2_b = bias_variable(shape=(c2_out,))
      conv2 = tf.nn.relu(conv2d(drop1, conv2_W) + conv2_b)
      pool2 = max_pool_2x2(conv2)
      drop2 = tf.nn.dropout(pool2, keep_prob=keep_prob)
      fc0 = tf.concat(1, [flatten(drop1), flatten(drop2)])
      fc1_out = 64
      fc1_W = weight_variable(shape=(fc0._shape[1].value, fc1_out))
      fc1_b = bias_variable(shape=(fc1_out,))
      fc1 = tf.matmul(fc0, fc1_W) + fc1_b
      drop_fc1 = tf.nn.dropout(fc1, keep_prob=keep_prob)
      fc2_out = n_classes
      fc2_W = weight_variable(shape=(drop_fc1._shape[1].value, fc2_out))
      fc2_b = bias_variable(shape=(fc2_out,))
      logits = tf.matmul(drop_fc1, fc2_W) + fc2_b
      return logits</copy>
      ```

      ```
      # placeholders
      <copy>x = tf.placeholder(dtype=tf.float32, shape=(None, 32, 32, 1))
      y = tf.placeholder(dtype=tf.int32, shape=None)
      keep_prob = tf.placeholder(tf.float32)</copy>
      ```

      ```
      # training pipeline
      <copy>lr = 0.001
      logits = my_net(x, n_classes=n_classes)
      cross_entropy = tf.nn.sparse_softmax_cross_entropy_with_logits(logits=logits, labels=y)
      loss_function = tf.reduce_mean(cross_entropy)
      optimizer = tf.train.AdamOptimizer(learning_rate=lr)
      train_step = optimizer.minimize(loss=loss_function)</copy>
      ```

5.  The final architecture is a relatively shallow network made by four layers. The first two layers are convolutional, and the third and fourth are fully connected. Following [Sermanet and LeCun](http://yann.lecun.com/exdb/publis/pdf/sermanet-ijcnn-11.pdf), the output of both the first and second convolutional layers are concatenated and fed to the following dense layr. In this way, we provide the fully connected layer visual patterns at both different levels of abstraction. The last fully connected layer then maps the prediction into one of the 43 classes.

      ```
      # metrics and functions for model evaluation
      <copy>correct_prediction = tf.equal(tf.argmax(logits, 1), tf.cast(y, tf.int64))
      accuracy_operation = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
      def evaluate(X_data, y_data):
        num_examples = X_data.shape[0]
        total_accuracy = 0

        sess = tf.get_default_session()
      
      for offset in range(0, num_examples, BATCHSIZE):
        batch_x, batch_y = X_data[offset:offset+BATCHSIZE], y_data[offset:offset+BATCHSIZE]
        accuracy = sess.run(accuracy_operation, feed_dict={x: batch_x, y: batch_y, keep_prob:
        1.0})
        total_accuracy += accuracy * len(batch_x)

      return total_accuracy / num_examples</copy>
      ```

      ```
      # create a checkpointer to log the weights during training
      <copy>checkpointer = tf.train.Saver()</copy>
      ```

      ```

      # training hyperparameters
      <copy>BATCHSIZE = 128
      EPOCHS = 30
      BATCHES_PER_EPOCH = 5000</copy>

      ```

      ```
      # start training
      <copy>with tf.Session() as sess:
        sess.run(tf.global_variables_initializer())
        
        for epoch in range(EPOCHS):
          print("EPOCH {} ...".format(epoch + 1))
          batch_counter = 0
          
          for batch_x, batch_y in image_datagen.flow(X_train_norm, y_train,
          batch_size=BATCHSIZE):
            batch_counter += 1
            sess.run(train_step, feed_dict={x: batch_x, y: batch_y, keep_prob: 0.5})
            if batch_counter == BATCHES_PER_EPOCH:
              break
        
          # at epoch end, evaluate accuracy on both training and validation set
          train_accuracy = evaluate(X_train_norm, y_train)
          val_accuracy = evaluate(X_val_norm, y_val)
          print('Train Accuracy = {:.3f} - Validation Accuracy: {:.3f}'.format(train_accuracy,val_accuracy))

          # log current weights
          checkpointer.save(sess, save_path='../checkpoints/traffic_sign_model.ckpt', global_step=epoch)
      ```
          
          # output
          EPOCH 1 ...
          Train Accuracy = 0.889 - Validation Accuracy: 0.890
          EPOCH 2 ...
          Train Accuracy = 0.960 - Validation Accuracy: 0.955
          EPOCH 3 ...
          Train Accuracy = 0.975 - Validation Accuracy: 0.969
          EPOCH 4 ...
          Train Accuracy = 0.985 - Validation Accuracy: 0.977
          EPOCH 5 ...
          Train Accuracy = 0.987 - Validation Accuracy: 0.978
          EPOCH 6 ...
          Train Accuracy = 0.991 - Validation Accuracy: 0.985
          EPOCH 7 ...
          Train Accuracy = 0.991 - Validation Accuracy: 0.984
          EPOCH 8 ...
          Train Accuracy = 0.991 - Validation Accuracy: 0.985
          EPOCH 9 ...
          Train Accuracy = 0.991 - Validation Accuracy: 0.985
          EPOCH 10 ...
          Train Accuracy = 0.994 - Validation Accuracy: 0.988
          EPOCH 11 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.990
          EPOCH 12 ...
          Train Accuracy = 0.995 - Validation Accuracy: 0.989
          EPOCH 13 ...
          Train Accuracy = 0.995 - Validation Accuracy: 0.991
          EPOCH 14 ...
          Train Accuracy = 0.993 - Validation Accuracy: 0.988
          EPOCH 15 ...
          Train Accuracy = 0.995 - Validation Accuracy: 0.989
          EPOCH 16 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.992
          EPOCH 17 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.992
          EPOCH 18 ...
          Train Accuracy = 0.997 - Validation Accuracy: 0.992
          EPOCH 19 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.992
          EPOCH 20 ...
          Train Accuracy = 0.993 - Validation Accuracy: 0.986
          EPOCH 21 ...
          Train Accuracy = 0.997 - Validation Accuracy: 0.993
          EPOCH 22 ...
          Train Accuracy = 0.995 - Validation Accuracy: 0.988
          EPOCH 23 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.990
          EPOCH 24 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.991
          EPOCH 25 ...
          Train Accuracy = 0.997 - Validation Accuracy: 0.991
          EPOCH 26 ...
          Train Accuracy = 0.997 - Validation Accuracy: 0.991
          EPOCH 27 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.994
          EPOCH 28 ...
          Train Accuracy = 0.997 - Validation Accuracy: 0.992
          EPOCH 29 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.992
          EPOCH 30 ...
          Train Accuracy = 0.996 - Validation Accuracy: 0.991
6. Now, we can go ahead and test the model. We load the weights of the epoch with the highest accuracy on the validation set. 

    
    
    
    
    ```
   #testing the model
   <copy>with tf.Session() as sess:
      #restore saved session with highest validation accuracy
      checkpointer.restore(sess, '../checkpoints/traffic_sign_model.ckpt-27')

      test_accuracy = evaluate(X_test_norm, y_test)
      print('Performance on test set: {:.3f}'.format(test_accuracy))
    ```

    ```
    #output
    Performance on test set: 0.953
    ```

7. For the training, we used **Adam optimizer**, which is a good choice to avoid the patient search of the right parameters for SGD. Batch size was set to 128 due to memory constraint. Every 5,000 batches visited, an evaluation on both training and validation set is performed. To avoid overfitting, both data augmentation and dropout (with drop probability of 0.5) are employed extensively. 

8. The network architecture is based on the [paper by Sermanet and LeCun](http://yann.lecun.com/exdb/publis/pdf/sermanet-ijcnn-11.pdf), in which the authors tackle the same problem (traffic sign classification) but use a different dataset. In section II-A of the paper, the authors explain that they found it beneficial to feed the dense layers with the output of both the previous convolutional layers. In this way, the classifier is explicitly provided both the local "motifs" (learned by conv1) and the more "global" shapes and structure (learned by conv2) found in the features. We tried to replicate the same architecture, made by two convolutional and two fully connected layers. The number of features learned was lowered until the training was feasible also in a laptop. 

## **STEP 4: Test the Model on New Images**

1. Take several pictures of traffic signs that you find on the web or around you (at least five), and run them
through your classifier on your computer to produce example results. The classifier might not recognize some
local signs. You might find signnames.csv useful; it contains mappings from the class id (integer) to the actual sign
name.

2.  Next is the implementation step. Use the code cell (or multiple code cells, if necessary) to implement the first step of your project. After you’ve completed your implementation and are satisfied with the results, be sure to thoroughly answer the questions
that follow.

    ```
    <copy>import os

    # load new images
    new_images_dir = '../other_signs'
    new_test_images = [os.path.join(new_images_dir, f) for f in os.listdir(new_images_dir)]
    new_test_images = [cv2.cvtColor(cv2.imread(f), cv2.COLOR_BGR2RGB) for f in new_test_images]

    # manually annotated labels for these new images
    new_targets = [1, 13, 17, 35, 40]

    # plot new test images
    fig, axarray = plt.subplots(1, len(new_test_images))
    for i, ax in enumerate(axarray.ravel()):
      ax.imshow(new_test_images[i])
      ax.set_title('{}'.format(i))
      plt.setp(ax.get_xticklabels(), visible=False)
      plt.setp(ax.get_yticklabels(), visible=False)
      ax.set_xticks([]), ax.set_yticks([])
    
    ```


#### All Done! This completes the demo for building a convolutional neural network in TensorFlow to classify traffic sign images.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca
* **Last Updated By/Date** - Harrison Dvoor (10/20)


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

**You may now proceed to the next lab**