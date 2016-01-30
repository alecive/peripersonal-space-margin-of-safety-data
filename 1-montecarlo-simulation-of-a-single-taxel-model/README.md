# Instructions

This file contains the tutorial to retrieve Figure 2 and Figure 3 (built up from Montecarlo simulation of a single taxel model).

The Montecarlo simulation takes a long amount of time to run. For this reason, we are providing two `.mat` files with the training performed in both the noise-less and the non noisy condition. To retrieve the Figures, simply run the script called `main_montecarlo_simulation.m`. For Figure 2, be sure to uncomment line 3 from `main_montecarlo_simulation.m` (and comment line 4). Conversely, for Figure 3 comment line 3 and uncomment line 4.

 * Figure 2: Representation learned in single taxel model. D and T T C estimated from distance and velocity of the object. (Left) Full 3D graph of the representation. The z−axis is given by the activation - estimate of the probability of object eventually landing on the taxel. (Right) 2D projection; third dimension preserved in the color map.
 * Figure 3. Representation learned in single taxel model with noise and systematic error (−10cm offset). See Figure 2 for interpretation of the figure.

The script does the following:

 * Loading either `Fig2.mat` or `Fig3.mat` files
 * Creating a `figure` in which the user can see both the 3D representation of the learning of the taxel after 500 iterations and its 2D counterpart
 * Saving an `eps` figure (either `Fig2.eps` or `Fig3.eps`) - the same that has been submitted
 * Outputting on the Matlab prompt a two-dimensional visualization of the learned visuo-tactile representation. This matrix is an 8x4 matrix that represents the discretized landscape (D,TTC), and it is the one that has been used at the visualization stage

It is also possible to run the simulations (instead of loading the provided `.mat` files).
