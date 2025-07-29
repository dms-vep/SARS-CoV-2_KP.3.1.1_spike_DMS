---
aside: false
---

# Antibody Escape

Plot below shows effects of mutations to KP.3.1.1 spike on neutralization by BD55-1205, SA55 and VYD222 antibodies. 

The plot below is interactive, and allows you to zoom and mouseover sites and mutations. Click on the expansion box in the upper right of the plot to enlarge it for easier viewing. Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot). Select floor escape at zero False to see mutations that increase antibody neutralization. Use a drop down to display heatmap for specific antibody.

## Effects of mutations to spike on BD55-1205, SA55 and VYD222 antibody neutralization

<Figure caption="BD55-1205, SA55 and VYD222 antibody escape">
    <Altair :showShadow="true" :spec-url="'htmls/antibody_escape_faceted.html'"></Altair>
</Figure>



## Interactive structures

Below are interactive visualizations showing deep mutational scanning data for antibody escape in the context of protein structure. These visualizations were made using the [dms-viz](https://dms-viz.github.io/dms-viz-docs/) platform. To see antibody escape data overlaid as heatmap over the RBD highlight some or all sites on the line plot above the structure. For a better visual under Protein Options on the left set ‘protein representation’ to cartoon and ‘selection representation’ to surface.

### BD55-1205
<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_BD55-1205.json" width="100%" height="500px"></iframe>

### SA55
<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_SA55.json" width="100%" height="500px"></iframe>

### VYD222
<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_VYD222.json" width="100%" height="500px"></iframe>