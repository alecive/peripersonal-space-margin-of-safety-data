# Instructions

This file contains the tutorial to retrieve Figure 8 and Figure 9 (as a result of exploitation of the learned associations through avoidance and reaching with arbitrary body parts).

We are providing a `.mat` file with the data collected from the robot and the experiments. To retrieve the Figures, simply run the script called `main.m`. It will produce all of the figures needed.

 * Figure 8: Avoidance behavior demonstration.
 * Figure 9: Reaching with arbitrary body parts.

The script does the following:

 * Loading the `data.mat` file
 * Creating a two Matlab `figures` in which the user can see the result of the experiments during both the avoidance and the reaching task. Their interpretation is the same as the one provided on the paper:
   * Figure 8 **(Left)** Object approaching the inner part of left forearm. Nine taxels of the left forearm (six on the inner part, $FAL_{i}$ $1:6$; $FAL_{i}$ stands for forearm left internal; three on the outer part, $FAL_{o}$ $1:3$) were considered in the experiment. Top plot shows the distance of the object from the taxels in their individual FoRs. The shaded purple area marks the velocity of the body part (common to all taxels; maximum activation corresponding to $10 cm/s$). Bottom plot depicts the activations of the forearm taxels' PPS representations. **(Right)** Object approaching the right palm. There were three taxels considered ($PR$ $1:3$, where PR stands for "palm right").
   * Figure 9 Object approaching the inner part of left forearm. Nine taxels of the left forearm (six on the inner part; three on the outer part) were considered in this experiment. Top plot shows the distance of the object from the taxels in their FoRs. The shaded purple area marks the velocity of the body part due to the activation of the controller. The bottom plot depicts the activations of the forearm taxels. The green shaded area marks physical contact with the robot's skin -- aggregated activation of all taxels contacted on the body part.
 * Saving corresponding `eps` and `png` figures - the same that have been submitted

It is also possible to show the results from all the other taxels that have been trained. The `experiments.mat` file stores information of all the 16 different experimental sessions that have been performed. Some of them are not shown in the paper.
