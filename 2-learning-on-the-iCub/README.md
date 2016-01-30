# Instructions

This file contains the tutorial to retrieve Figure 4, Figure 5 and Figure 7 (built up from real experiments on the iCub robot).

We are providing a `.mat` file with the data collected from the robot and the training performed in all the conditions. To retrieve the Figures, simply run the script called `main_learning_on_the_iCub.m`. It will produce all of the figures needed.

 * Figure 4: Tactile-motor representation learned in the double-touch scenario. Results for taxel nr. 2 on the inner part of the left forearm.
 * Figure 5: Tactile-visual representation learned in double-touch scenario. Results for taxel nr. 2 on the inner part of the left forearm
 * Figure 7: Tactile-visual representation learned from oncoming objects. (Left) Inner part of left forearm (taxel nr. 2). (Middle) Outer part of left forearm (taxel nr. 8). (Right) Right hand (taxel nr. 2).

The script does the following:

 * Loading the `experiments.mat` file
 * Creating a set of Matlab `figures` in which the user can see both the 3D representation of the learning of the taxel after 500 iterations and its 2D counterpart
 * Saving corresponding `eps` and `png` figures - the same that have been submitted
 * Outputting on the Matlab prompt a two-dimensional visualization of the learned visuo-tactile representation. This matrix is an 8x4 matrix that represents the discretized landscape (D,TTC), and it is the one that has been used at the visualization stage

It is also possible to show the results from all the other taxels that have been trained. The `experiments.mat` file stores information of all the 16 different experimental sessions that have been performed. Some of them are not shown in the paper.
