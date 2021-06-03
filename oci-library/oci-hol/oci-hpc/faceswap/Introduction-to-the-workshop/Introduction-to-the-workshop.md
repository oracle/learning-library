# Introduction to the workshop

## What you will learn in this workshop

In this workshop you will learn how to run the deepfake application [Faceswap](https://faceswap.dev/) on a GPU virtual machine on the Oracle Cloud Infrastructure. We will cover all steps from the provisioning and the preparation of the instance to utilize the GPU cores to run the Python script (Faceswap GAN) for the extraction of the faces, training the GAN and the conversion of the swapped face in a video.

Estimated workshop time: 120 minutes (excl. training time of the GAN)

## What is deepfake

Deepfake is a compound word of “deep learning” and “fake” and stands for AI-generated media in which a person in an existing picture or video is replaced with someone else or modified with other external features (such as age, hairstyle, skin color, voice etc.). The act of manipulating videos and images has been around for a long time, but leveraging machine learning and AI to produce media with a high potential for deception is new. It is almost impossible to distinguish real and fake media with the naked eye.

## How does deepfake work?

Deepfakes are based on artificial neural networks that recognize patterns (e.g. faces, voices) in data (photos or videos of people). A large amount of data is entered into neural networks which are trained to recognize patterns and fake them.
Neuronal networks are algorithms that are inspired by the human brain. A neuron receives and transmits signals to and from other neurons through their synapses over axons and dendrites, with the goal to e.g. contract a muscle. When a signal moves from A to B, it may be passed on by layers of neurons. Similarly, a neural network algorithm receives input data, processes it through a layer of mathematical operations (matrix multiplications) equipped with different weights, which are adjusted during the training, and finally generates an output.

In order to execute matrix multiplications with 10 billion of parameters in a timely manner, one needs adequate computing power. It is faster to run all operations at the same time instead one after another. A CPU executes one process after another with a small number of threads, whereas a GPU facilitates parallel computing with a large number of threads at the same time. The ability to process multiple computations at the same time, makes GPU a better choice to train neural network algorithms.
The neuronal networks that are used for deepfakes are called GANs (Generative Adversial Networks) where two machine learning models compete with each other. The first model is called the generator that reads the real data and generates fake data. The second model called the discriminator is responsible for detecting the fake data. The generator generates fake data until the discriminator is not able to detect them anymore. The more training data is available for the generator, the easier it gets for it to generate a credible deepfake.

## What is Faceswap?

The currently best known and most widespread platform for generating deepfakes is [Faceswap](https://faceswap.dev/). It is an open source platform based on Tensorflow, Keras and Python and can be run on Windows, macOS and Linux. An active community has formed, which exchanges information on Github and other forums and shares scripts and suggested solutions to questions.

You can run your deepfake workloads using the Oracle Free Tier that consists of the Always Free Offering and a 30-day free trial. In the Always Free Tier, the VM.Standard.E2.1.Micro can be utilized and in the 30-Day trial, all available VM and BMs instances can be tested. If you want to test the GPU offering, you can upgrade your Oracle cloud account to PAYG.

## **Acknowledgements**

- **Created By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
- **Last Updated By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
