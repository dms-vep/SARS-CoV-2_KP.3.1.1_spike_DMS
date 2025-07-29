---
aside: false
---

# Serum escape 

We have mapped mutations in spike that affect neutralization by sera from individuals who have been exposed to JN.1* spike by infection or vaccination. For the same individuals we have also mapped escape prior to the last exposure to JN.1* spike. 

The plot below is interactive, and allows you to zoom and mouseover sites and mutations. Click on the expansion box in the upper right of the plot to enlarge it for easier viewing. Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot). You can also select floor escape at zero False to see mutations that increase sera neutralization.
 
## Effects of mutations to spike on pre- and post-infection/vaccination sera neutralization
<Figure caption="Effects of mutations to spike on pre and post infection/vaccination sera neutralization">
    <Altair :showShadow="true" :spec-url="'htmls/sera_group_averages_overlaid.html'"></Altair>
</Figure>


## Comparison between effects of mutations on pre- and post-infection/vaccination for each individual

Below plots allow to explore differences in neutralization effects of mutations pre- and post-infection/vaccination for each of the seven individuals measured. Pre-infection/vaccination escape is shown in blue and post--infection/vaccination is in yellow. You can zoom in using a bar at the top to look in more detail at specific regions.
<Figure caption="Effects of mutations to spike on pre and post infection/vaccination sera neutralization by individual">
    <Altair :showShadow="true" :spec-url="'htmls/compare_pre_post_escape.html'"></Altair>
</Figure>