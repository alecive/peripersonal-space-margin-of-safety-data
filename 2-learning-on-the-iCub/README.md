# Instructions

This folder contains the tutorial to retrieve Figure 4, Figure 5, Figure 7, and Figure 8 (built up from real experiments on the iCub robot).

We are providing a `.mat` file with the data collected from the robot and the training performed in all the conditions. In addition, there are also two Matlab scripts used to create the Figures. They are illustrated in the following sub-sections.

## `main_learning_on_the_iCub.m`

This script will produce Figure 4, Figure 5, and Figure 7:

 * Figure 4: Tactile-motor representation learned in the double-touch scenario. Results for taxel nr. 2 on the inner part of the left forearm.
 * Figure 5: Tactile-visual representation learned in double-touch scenario. Results for taxel nr. 2 on the inner part of the left forearm
 * Figure 7: Tactile-visual representation learned from oncoming objects. (Left) Inner part of left forearm (taxel nr. 2). (Middle) Outer part of left forearm (taxel nr. 8). (Right) Right hand (taxel nr. 2).

The script does the following:

 * Load the `experiments.mat` file
 * Create a set of Matlab `figure`s in which the user can see both the 3D representation of the learning of the taxel after 500 iterations and its 2D counterpart
 * Save corresponding `eps` and `png` figures - the same that have been submitted
 * Output on the Matlab prompt a two-dimensional visualization of the learned visuo-tactile representation for all the experiments. This matrix is an 8x4 matrix that represents the discretized landscape (D,TTC), and it is the one that has been used at the visualization stage

It is also possible to show the results from all the other taxels that have been trained. The `experiments.mat` file stores information of all the 16 different experimental sessions that have been performed. Most of them are not shown in the paper, but they are included here for completeness.

## `main_systematic_offsets`

This script will produce Figure 8:

 * Fig 8. Systematic offsets computed during tactile-visual learning using external objects. The distance offset in the learned representation of ten taxels (three on the inner part of the left forearm, FALi; three on the outer part, FALo; four in the right palm, PR) is depicted in red. For each of the three body parts under consideration, average offset and standard deviation are depicted in blue.

The script does the following:



## `main_evolution_of_the_learning_process.m`

This script will produce Figure 9:

 * Figure 9: Evolution of the learning process. The progress of the learned representations belonging to two adjacent taxels of the internal part of the left forearm is shown. For each of the two taxels (taxel nr. 3 on the left column and taxel nr. 4 on the right column), snapshots of their respective representations after 1, 4 and 53 trials are depicted.

The script does the following:

 * Load the `learning_process.mat` file
 * Create a Matlab `figure` in which the user can see the 2D representation of the learning the taxels nr. 3 and 4 after 1, 4 and 53 iterations during real-robot experiments.
 * Save corresponding `eps` and `png` figures - the same that have been submitted
 * Output on the Matlab prompt a two-dimensional visualization of the learned visuo-tactile representation for said experiments. This matrix is an 8x4 matrix that represents the discretized landscape (D,TTC), and it is the one that has been used at the visualization stage
