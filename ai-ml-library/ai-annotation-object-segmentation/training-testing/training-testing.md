# Training and Testing

## Introduction
This lab will use two python scripts to run a training on the annotated dataset and test the model for effectiveness.  The scope of this lab is limited in order to be more timely. The first areas to look at when trying optimize a model are adding images to the training dataset and increasing the number of iterations over the data (epochs) during training. 

We are training a small dataset of only 20 images, which will not produce a model strong enough to be generalized to new data. The example scripts provided will show how to run a training with detectron2 and a prediction test. The prediction script is customizable to be able to use either a pre-trained model or a custom model

Estimated Lab Time:  45 minutes

### Objectives
In this lab, you will learn about:
* Training a model
* Testing the model

### Prerequisites

This lab assumes you have:
- Completed the previous lab, Annotating images with COCO Annotator

## **STEP 1**: Download the Scripts

1. [The training and testing scripts can be downloaded here.](https://objectstorage.us-ashburn-1.oraclecloud.com/p/Me4VsLIUHWzJ-GJ1C5_1dTuMwzDNWQbubhP0lJwqxdsOWpwiBoAUe0HFxHzx_w_Y/n/c4u03/b/ai-ml-library/o/jblau-ai-object-detection.zip) 

2. Download the zip file and put it in the `coco-annotation` directory on the instance and extract the contents. This should be the same directory where the `datasets` directory is located. The scripts are configured to look for the `datasets` directory in the location where they reside.

## **STEP 2**: Review the Training Script and Run

1. Open the script to get an understanding for the different parameters that can be changed for the training.

    ### Parameters for locating traing and testing dataset
    `DATASET_NAME_TRAINING`: The string used to access the dataset after it is loaded into memory by the detectron2 framework

    `DATASET_ANNOTATION_TRAIN_PATH`: The location of the annotation JSON file

    `DATASET_IMAGES_TRAIN_PATH`: The location of the training images


    ### Hyperparameters for model training
    `NUM_WORKERS`: Number of CPU workers used to load data onto the GPU. If not using a GPU leave the value as-is and ignore it, the framework handles cases for CPU-only workloads.

    `IMAGES_PER_BATCH`: The number of images per batch that are loaded onto the GPU. This value can be increased to consume more of the GPU memory, but putting it too high can results in a runtime error. The best practice is to run the script and use `nvidia-smi` to observe the GPU memory utilization, and adjust the value accordingly.

    `MAX_ITERATIONS`: The number of times that the training script will iterate over the data before finishing. This value is low for the lab, but should be increased when trying to build a production model. Observe the output training `loss` value as the training runs. Artificial Intelligence trainings are complete when the `loss` value is no longer significantly changing from iteration to iteration, meaining that the model is not changing.

    `BATCH_SIZE_PER_IMAGE`: This value can be increased when running for production models.

    `NUM_CLASSES`: The number of classes (categories in COCO Annotator) in the dataset. We have `apples` and `oranges`, so the value of 2 is correct.


    ### Training Options
    `OUTPUT_DIR`: The directoy where the model and checkpoints will be saved

    `RESUME_FROM_LAST_CHECKPOINT`: Change this value to `true` to resume training from the last checkpoint in `OUTPUT_DIR`. Otherwise the training will start training a model from scratch.

    ### Viewing the annotations

    If you would like to verify that the annotations are being properly loaded by the framework, uncomment lines 34-42. This will output a sampling of files to the base directory of the script that you can view and check for correctness.

    ### Run the training script

    With our experiment configured, we can issue a command to run the script. Navigate to a terminal on the instance and change the directory to where the script is extracted. Run the following command to start the training.

        python training.py

    Successful output to the console should look like this

        [11/24 17:17:38 d2.utils.events]:  eta: 0:03:49  iter: 19  total_loss: 5.922  loss_cls: 1.709  loss_box_reg: 0.001663  loss_mask: 0.6814  loss_rpn_cls: 2.287  loss_rpn_loc: 1.211  time: 0.8241  data_time: 0.8461  lr: 3.9962e-05  max_mem: 1966M

        [11/24 17:17:54 d2.utils.events]:  eta: 0:03:32  iter: 39  total_loss: 2.457  loss_cls: 0.767  loss_box_reg: 0.001148  loss_mask: 0.5905  loss_rpn_cls: 0.5089  loss_rpn_loc: 0.6184  time: 0.8217  data_time: 0.7038  lr: 7.9922e-05  max_mem: 1966M

        [11/24 17:18:11 d2.utils.events]:  eta: 0:03:15  iter: 59  total_loss: 1.394  loss_cls: 0.2306  loss_box_reg: 0.001378  loss_mask: 0.3332  loss_rpn_cls: 0.351  loss_rpn_loc: 0.4741  time: 0.8217  data_time: 0.7057  lr: 0.00011988  max_mem: 1966M
        

    If the script quits with errors, the two most likely issues are either that detectron2 is not installed for the python environment you are using, or that the file locations are incorrect. The setup guide pays particular attention to the file locations to avoid this, so review that lab to correct issues.

    After `MAX_ITERATIONS` is hit, a model will be saved to `OUTPUT_DIR` with the name `model_final.pth` and the script will exit. Checkpoint models are also saved with the iteration number, such as `model_004999.pth`.

## **STEP 3**: Review the Validation Script and Run

1. Open the prediction script to review the parameters

    ### Dataset parameters
    `USE_COCO_DEMO`: This will pull a pre-trained model from detectron2's library for demonstration. Change value to *False* to use a model from the training script output. Note that you will need to add more data to the training dataset to arrive at a model that can be generalized to new data.

    `DATASET_NAME_VALIDATION`: The string used to access the dataset after it is loaded into memory by the detectron2 framework

    `DATASET_ANNOTATION_VALIDATION_PATH`: The location of the validation annotation JSON file

    `DATASET_IMAGES_VALIDATION_PATH`: The location of the validation images


    ### Model parameters

    `MODEL_DIR`: Directory where the model is stored. This should the directory created by the training script named `output`

    `MODEL_FILENAME`: The filename for the saved model you would like to test. Default is `model_final.pth`


    ### Hyperparameters

    `NUM_WORKERS`: Number of CPU workers used to load data onto the GPU. If not using a GPU leave the value as-is and ignore it, the framework handles cases for CPU-only workloads.

    `NUM_CLASSES`: The number of classes (categories in COCO Annotator) in the dataset. We have `apples` and `oranges`, so the value of 2 is correct


    ### Prediction options
    `SCORE_THRESHOLD`: Minimum accuracy in percent (0.7 = 70%) to report a positive result

    `RESULTS_DIR`: Where the results of the test should be saved


2. Run the following command to start the prediction.

    python prediction.py

    Once complete, check the results to see if the model was able to correctly identify and outline `apples` and `oranges`. By default the script will use a pre-trained model pulled from detectron2's library. The next step is to return to the start and add more images and train a model with higher values for `MAX_ITERATIONS` to build a more robust model. To test a custom model change `USE_COCO_DEMO` to *False*, which will use the model from the output of the training.

## Acknowledgements
* **Author** - Justin Blau, Senior Solutions Architect, Big Compute
* **Last Updated By/Date** - Justin Blau, Big Compute, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/artificialintelligence). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.