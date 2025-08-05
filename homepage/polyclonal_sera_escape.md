---
aside: false
---

# Polyclonal sera escape 

We measured how mutations in the KP.3.1.1 spike that affect neutralization by sera from individuals who were imprinted by early COVID strains and then recently exposed to the spike of a JN.1-descended strain by infection or vaccination. For the same individuals we have also measured the effects on neutralilization rior to the last exposure to JN.1* spike. 

Below are several ways to explore these data:
[[toc]]

## Line plots and heatmaps showing effects of mutations summarized by exposure group

The plot below is interactive, and allows you to zoom and mouseover sites and mutations.
Click on the expansion box in the upper right of the plot to enlarge it for easier viewing, or click [here](htmls/sera_group_averages_overlaid.html){target="_self"} for a standalone version of the plot.
The line plots summarize the effects of mutations at each measured site, while the heatmaps below show the effects of individual mutations.
Each panel groups all pre- or post- infection/vaccination sera.
Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot).
By default the plot only shows positive escape (mutations that reduce neutralization), but if you set the *floor escape at zero* option at the bottom of the plot then you can also see mutations that increase serum neutralization (negative escape).
 
<Figure caption="Effects of mutations to spike on pre and post infection/vaccination sera neutralization for each exposure group">
    <Altair :showShadow="true" :spec-url="'htmls/sera_group_averages_overlaid.html'"></Altair>
</Figure>


## Per-individual comparison of effects of mutations neutralization by pre- and post-infection/vaccination serum

The plots below show the effects of mutations on neutralization by sera from the same individual collected either pre- or post-infection/vaccination.
The scatter plots show the effects of individual mutations, and the line plots show the total effects of mutations at each site pre- (blue) or post- (yellow) infection/vaccination.
The zoom bar at top allows you to examine just certain regions of spike.
Click [here](htmls/compare_pre_post_escape.html){target="_self"} for a standalone version of this plot.

<Figure caption="Effects of mutations neutralization by pre- and post- infection/vaccination sera from the same individual">
    <Altair :showShadow="true" :spec-url="'htmls/compare_pre_post_escape.html'"></Altair>
</Figure>


## Interactive structure visualizations

Below are interactive visualizations showing the effects of the mutations on sera escape in the context of the spike protein structure.
These visualizations were made using the [dms-viz](https://dms-viz.github.io/dms-viz-docs/) platform. 
To see sera escape at each site onr the spike structure select, the sera group you want to see under Chart Options on the left and then highlight some or all sites on the line plot above the structure.
For a better visual under Protein Options on the left set ‘protein representation’ to cartoon and ‘selection representation’ to surface.
For a standalone version of this visualization, use [this link](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_sera.json).

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_sera.json" width="100%" height="500px"></iframe>

## Numerical values
For numerical values, see [this CSV](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS/blob/main/results/summaries/sera_group_averages.csv). Note that these show all mutations, for the plots above we filter only to escape of mutations with at least some minimal cell entry score as indicated by the sliders below the plots.
