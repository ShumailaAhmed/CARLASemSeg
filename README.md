# Semantic Segmentation on CARLA dataset
## Introduction
This project is for a image semantic segmantation challenge by Lyft & Udacity, the algorithm was benchmarked on a video recorded using [CARLA](http://carla.org/), CARLA is an open-source simulator for autonomous driving research.

This is a postmortem for this project. This article will discuss the 3 following topics:

1. How I setup the architecture of the project,
1. What are the challenges and what's my solution to them,
1. What are the potential improvement for this project.

Now, let's get started!

## Deep Neural Network Architecture of the project

### Fully Convolutional Network



### Other solutions

#### Mask R-CNN

[Mask R-CNN](https://arxiv.org/abs/1703.06870) is an object instance segmentation deep learning framework base on faster R-CNN. Mask R-CNN detects objects in an image while simultaneously generating a high-quality segmentation mask for each instance. In other words, **faster R-CNN create bounding box for each instance in the image, while mask R-CNN added a semantic segmentation stage within each bounding box.**

Here are some reasons I didn't select R-CNN for this task.
1. We don't have bounding box in training dataset, which means if we draw the bounding box according to semantic segmentation result, it won't be able to seperate vehicles that are overlay.
1. Spatial information are lost during the detection process, a vehicle on the left lane and in front of us will have different shape, but in the semantic segmentation stage of the mask R-CNN, this information has already disappear.
1. Using mask R-CNN on road surface doesn't seem to be a good fit in this situation to me. I'll prefer draw the bounding box by my self because the detection result of road surface would be very consistent. Which will give us just another fully convolutional network

#### Histogram of Oriented Gradient (HOG) + Linear SVM + Semantic Segmentation
This is another solution that I came up with, I didn't choosed this solution.

In my [Vehicle Detection project](https://github.com/EvanWY/CarND-Vehicle-Detection/blob/master/writeup.md), I used Histogram of Oriented Gradients (HOG) with linear SVM to classify vehicle, and using sliding window search to implemented vehicle detection framework. I optimized the framework using heatmap across multiple frames. One of the solution is to add a semantic segmentation stage on top of the detection bounding box result.

**Pros:** By applying multiple stages (classification, detection, heatmap, segmentation), this architecture would give me more control on each stage of the segmentation process. It would be easier to identify which step is the bottleneck.

**Cons:**
1. When 2 vehicle merged together in the image, It will be difficut to draw 2 bounding box for each of them to train the detector (bounding box not provided in the test dataset, need to draw them according to sem-seg result);
1. The sliding window + detection solution would not be fast enough to run in realtime;
1. Need to come up with another solution for road surface segmentation (Could be extended from this lane [dection](https://github.com/EvanWY/CarND-LaneLines-P1/blob/master/writeup.md) project)
1. **What's more important:** Why not use deep learning? It performed much better than conventional computer vision algorithm in tasks like this. :)

