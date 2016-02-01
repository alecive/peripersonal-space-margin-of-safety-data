# peripersonal-space-margin-of-safety-data


## Requirements

All of the data have been processed and visualized in [MatLab](http://www.mathworks.com/products/matlab/), and it is the only requirement for retrieving the data on this repository.

## Repository Structure

The repository is divided into three subfolders. Each of them deals with each of the three steps shown in the Results section of the paper. In particular:

 * `1-montecarlo-simulation-of-a-single-taxel-model` stores the "Learning in a single taxel model" data (i.e. the Matlab simulation of a single taxel);
 * `2-learning-on-the-iCub` tackles with the real learning experiments on the iCub robot. It is subdivided into:
   * Tactile-motor learning via double touch
   * Tactile-visual learning from double touch
   * Tactile-visual learning using external objects
 * `3-avoidance-and-reaching-with-arbitrary-body-parts` extrapolates the data recorded during the last experiments, i.e. the exploitation of the learned associations (performed at the previous stage), in order to implement an avoidance and reaching with any body part behavior.

## Video

For a video on the peripersonal space, click on the image below (you will be redirected to a youtube video):

[![peripersonal space video](http://img.youtube.com/vi/3IaXxNwC_7E/0.jpg)](http://www.youtube.com/watch?v=3IaXxNwC_7E)
