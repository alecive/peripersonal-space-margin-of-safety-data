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

It is worth noting that Figure 8 and Figure 9 show their respective experiments in small time windows (15s and 20s respectively) if compared to the total amount of experiments that have been performed. To this end, the `data.mat` file stores all of the experiments recorded. It is made of six structures, and each of them is composed of some useful information related to the experiment. In particular:

 * Filename
 * Raw data (the raw data is composed of an average of 4 matrices, each of them belonging to a different recording [e.g. skin activation, joint encoders, peripersonal space activations, and so on])
 * Length of acquisition

It is also possible to plot the raw data of all the acquisitions, if the user so chooses. To do so, simply type e.g.:

```
plotData(dump1)
```

The interpretation of the resulting graph is exactly the same as shown in the paper. In this case, though, the full acquisition is shown, instead of a small time window.
