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

1. Copy the training script to a file
```
# if your dataset is in COCO format, this cell can be replaced by the following three lines:
from detectron2.config import get_cfg
from detectron2.data.datasets import register_coco_instances
from detectron2.data.catalog import MetadataCatalog, DatasetCatalog
from detectron2.engine import DefaultTrainer
import os

# Parameters for locating traing and testing dataset
# NOTE: Train and Test images should be separate. They are the same in this tutorial for the sake of expedience

DATASET_NAME_TRAINING = "my_dataset_train"
DATASET_ANNOTATION_TRAIN_PATH = "./datasets/fruit-types/fruit-types.json"
DATASET_IMAGES_TRAIN_PATH = "./datasets/fruit-types/"

# Hyperparameters for model training
NUM_WORKERS = 2 # Number CPU workers loading GPU
IMAGES_PER_BATCH = 2
BASE_LEARNING_RATE = 0.002
MAX_ITERATIONS = 100000
BATCH_SIZE_PER_IMAGE = 128
NUM_CLASSES = 4

# Training options
OUTPUT_DIR = "./output"

# Change this to true to resume from the last checkpoint in OUTPUT_DIR
# This will start from the last iteration, so make sure MAX_ITERATIONS is above that value
RESUME_FROM_LAST_CHECKPOINT = True 


register_coco_instances(DATASET_NAME_TRAINING, {}, DATASET_ANNOTATION_TRAIN_PATH, DATASET_IMAGES_TRAIN_PATH)

metadata = MetadataCatalog.get(DATASET_NAME_TRAINING)
data_dicts = DatasetCatalog.get(DATASET_NAME_TRAINING)

# Uncomment below to write a sample of data to the output folder for setup verification
#from detectron2.utils.visualizer import Visualizer
#import random
#import cv2
#NUM_SAMPLES = 3
#for (i, d) in random.sample(data_dicts, NUM_SAMPLES):
#    img = cv2.imread(d["file_name"])
#    visualizer = Visualizer(img[:, :, ::-1], metadata=metadata, scale=0.5)
#    vis = visualizer.draw_dataset_dict(d)
#    cv2.imwrite("test-" + "str(i)" + ".jpg", vis.get_image()[:, :, ::-1])

cfg = get_cfg()
cfg.merge_from_file(
    "./configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml"
)
cfg.DATASETS.TRAIN = (DATASET_NAME_TRAINING,)
cfg.DATASETS.TEST = ()
cfg.DATALOADER.NUM_WORKERS = NUM_WORKERS
cfg.MODEL.WEIGHTS = "detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl"  # initialize from model zoo
cfg.SOLVER.IMS_PER_BATCH = IMAGES_PER_BATCH
cfg.SOLVER.BASE_LR = BASE_LEARNING_RATE
cfg.SOLVER.MAX_ITER = (
    MAX_ITERATIONS
) 
cfg.MODEL.ROI_HEADS.BATCH_SIZE_PER_IMAGE = (
    BATCH_SIZE_PER_IMAGE
)
cfg.MODEL.ROI_HEADS.NUM_CLASSES = NUM_CLASSES  

cfg.OUTPUT_DIR = OUTPUT_DIR

os.makedirs(cfg.OUTPUT_DIR, exist_ok=True)
trainer = DefaultTrainer(cfg)
trainer.resume_or_load(resume=RESUME_FROM_LAST_CHECKPOINT)
trainer.train()
```

2. Copy the testing script to a file
```
from detectron2.data.datasets import register_coco_instances
from detectron2.data.catalog import MetadataCatalog, DatasetCatalog
from detectron2.engine import DefaultPredictor
from detectron2.utils.visualizer import ColorMode, Visualizer
from detectron2.config import get_cfg
import os
import cv2

# Dataset parameters
USE_COCO_DEMO = True # This value should be true to use the COCO demo, false for custom model
DATASET_NAME_VALIDATION = "my_dataset_val"
DATASET_ANNOTATION_VALIDATION_PATH = "./datasets/fruit-types-val/fruit-types-val.json"
DATASET_IMAGES_VALIDATION_PATH = "./datasets/fruit-types-val/"

# Model parameters
MODEL_DIR = "./output/" # Based on the setting from the training script for output
MODEL_FILENAME = "model_final.pth"

# Hyperparameters
NUM_WORKERS = 2
NUM_CLASSES = 2

# Validation options
SCORE_THRESHOLD = 0.8 # Minimum accuracy in percent (0.7 = 70%) to report a positive result
RESULTS_DIR = "./results/"

def setup_cfg():
    cfg = get_cfg()
    cfg.merge_from_file(
        "./configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml"
    )
    if USE_COCO_DEMO is True:
        cfg.MODEL.WEIGHTS = "detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl"
    else:
        cfg.MODEL.WEIGHTS = os.path.join(MODEL_DIR, MODEL_FILENAME)
        cfg.MODEL.ROI_HEADS.NUM_CLASSES = NUM_CLASSES
        cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = SCORE_THRESHOLD

    cfg.MODEL.RETINANET.SCORE_THRESH_TEST = SCORE_THRESHOLD
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = SCORE_THRESHOLD
    cfg.MODEL.PANOPTIC_FPN.COMBINE.INSTANCES_CONFIDENCE_THRESH = SCORE_THRESHOLD
    cfg.DATALOADER.NUM_WORKERS = NUM_WORKERS
    cfg.DATASETS.TEST = (DATASET_NAME_VALIDATION, )

    return cfg

def run_prediction(predictor, image, metadata, instance_mode):
    predictions = predictor(image)
    # Convert image from OpenCV BGR format to Matplotlib RGB format.
    image = image[:, :, ::-1]
    visualizer = Visualizer(image, metadata, instance_mode=instance_mode)
    vis_output = None
    if "panoptic_seg" in predictions:
        panoptic_seg, segments_info = predictions["panoptic_seg"]
        vis_output = visualizer.draw_panoptic_seg_predictions(
            panoptic_seg.to("cpu"), segments_info
        )
    else:
        if "sem_seg" in predictions:
            vis_output = visualizer.draw_sem_seg(
                predictions["sem_seg"].argmax(dim=0).to("cpu")
            )
        if "instances" in predictions:
            instances = predictions["instances"].to("cpu")
            vis_output = visualizer.draw_instance_predictions(predictions=instances)

    return predictions, vis_output

register_coco_instances(DATASET_NAME_VALIDATION, {}, DATASET_ANNOTATION_VALIDATION_PATH, DATASET_IMAGES_VALIDATION_PATH)

metadata = None
if USE_COCO_DEMO is True:
    metadata = MetadataCatalog.get("__unused")
else:
    metadata = MetadataCatalog.get(DATASET_NAME_VALIDATION)

data_dicts = DatasetCatalog.get(DATASET_NAME_VALIDATION)

cfg = setup_cfg()
predictor = DefaultPredictor(cfg)

os.makedirs(RESULTS_DIR, exist_ok=True)
for i, d in enumerate(data_dicts):    
    im = cv2.imread(d["file_name"])
    outputs = predictor(im)
    predictions, vis_out = run_prediction(predictor, im, metadata, ColorMode.IMAGE_BW)
    vis_out.save(RESULTS_DIR + "result-" + str(i) + ".jpg")
```

3. Place the two files with the above scripts into the `coco-annotation` directory on the instance and extract the contents. This should be the same directory where the `datasets` directory is located. The scripts are configured to look for the `datasets` directory in the location where they reside.

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
