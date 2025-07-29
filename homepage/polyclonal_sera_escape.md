---
aside: false
---

# Serum escape 

We have mapped mutations in spike that affect neutralization by sera from individuals who have been exposed to JN.1* spike by infection or vaccination. For the same individuals we have also mapped escape prior to the last exposure to JN.1* spike. Line plots and heatmaps below show effects of mutations summarized by exposure group. 

The plot below is interactive, and allows you to zoom and mouseover sites and mutations. Click on the expansion box in the upper right of the plot to enlarge it for easier viewing. Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot). You can also select floor escape at zero False to see mutations that increase sera neutralization.
 
## Effects of mutations to spike on pre- and post-infection/vaccination sera neutralization
<Figure caption="Effects of mutations to spike on pre and post infection/vaccination sera neutralization">
    <Altair :showShadow="true" :spec-url="'htmls/sera_group_averages_overlaid.html'"></Altair>
</Figure>


## Comparison between effects of mutations pre- and post-infection/vaccination for each individual

Below plots allow to explore differences in neutralization effects of mutations pre- and post-infection/vaccination for each of the seven individuals measured. Pre-infection/vaccination escape is shown in blue and post--infection/vaccination is in yellow. You can zoom in using a bar at the top to look in more detail at specific regions.
<Figure caption="Effects of mutations to spike on pre and post infection/vaccination sera neutralization by individual">
    <Altair :showShadow="true" :spec-url="'htmls/compare_pre_post_escape.html'"></Altair>
</Figure>


## Interactive structure visualizations

Below are interactive visualizations showing deep mutational scanning data for sera escape in the context of protein structure. These visualizations were made using the [dms-viz](https://dms-viz.github.io/dms-viz-docs/) platform. To see sera escape data overlaid as heatmap over the spike structure select the sera group you want to see under Chart Options on the left and then highlight some or all sites on the line plot above the structure. For a better visual under Protein Options on the left set ‘protein representation’ to cartoon and ‘selection representation’ to surface.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_sera.json" width="100%" height="500px"></iframe>
