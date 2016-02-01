# Peripersonal Space and Margin of Safety Data

This repository stores the data that have been acquired for the PLOS submission called _Peripersonal Space and Margin of Safety Around the Body: Learning Visuo-tactile Associations in a Humanoid Robot with Artificial Skin_ .

## Requirements

All of the data have been processed and visualized in [MatLab](http://www.mathworks.com/products/matlab/), and it is the only requirement for retrieving the data on this repository.
To clone this repository, the user needs a working `git` client installed on his/her Operating System. If this is not available, it is also possible to download the repository as a `.zip` file by clicking on the `Download ZIP` button on the top of this page.

## Repository Structure

The repository is divided into three subfolders. Each of them deals with each of the three steps shown in the Results section of the paper. In particular:

 * `1-montecarlo-simulation-of-a-single-taxel-model` stores the "Learning in a single taxel model" data (i.e. the Matlab simulation of a single taxel);
 * `2-learning-on-the-iCub` tackles with the real learning experiments on the iCub robot. It is subdivided into:
   * Tactile-motor learning via double touch
   * Tactile-visual learning from double touch
   * Tactile-visual learning using external objects
 * `3-avoidance-and-reaching-with-arbitrary-body-parts` extrapolates the data recorded during the last experiments, i.e. the exploitation of the learned associations (performed at the previous stage), in order to implement an avoidance and reaching with any body part behavior.

Each of these subfolders is provided with a `README.md` file that explains the content of the folder and how to run the scripts. If the user is not provided with a software able to read and process `.md` files, it is always possible to view them online (e.g. [here](https://github.com/alecive/peripersonal-space-margin-of-safety-data/blob/master/README.md)), or to rename them as `.txt` files and open them with more standard applications.

Please note that the subfolder named `0-utils` contains only utility functions used by the other subfolders, e.g. the `export_fig` package to save `.eps` figures (source code also avalaible at [this link](http://www.mathworks.com/matlabcentral/fileexchange/23629-export-fig)). It is not in the scope of this repository to explain the functioning of the files contained in that subfolder.

## Video

For a video on the peripersonal space, click on the image below (you will be redirected to a youtube video):

[![peripersonal space video](http://img.youtube.com/vi/3IaXxNwC_7E/0.jpg)](http://www.youtube.com/watch?v=3IaXxNwC_7E)
