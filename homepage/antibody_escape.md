---
aside: false
---

# Monoclonal Antibody Escape

We measured how mutations to the KP.3.1.1 spike affected neutralization by three important monoclonal antibodies, BD55-1205, SA55 and VYD222 antibodies.
You can access these data in several ways:
[[toc]]

## Interactive lineplots and heatmaps of effects of mutations on antibody neutralization

### All three antibodies shown together

The interactive chart below shows effects of mutations to all three antibodies.
Click [here](htmls/antibody_escape_faceted.html){target="_self"} for a standalone version of this chart.

The line plot at top shows the total escape caused by mutations at each site for each antibody.
The heatmaps below show the effects of individual mutations, and you can use the dropdown at bottom to select which antibody is shown in the heatmap.
You can also mouse over points for details, zoom using the zoom bar at top, and adjust various options using the settings below the chart.
Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot). 
Select *floor escape at zero* to *False* at the bottom of the chart to see mutations that increase antibody neutralization (negative escape).

<Figure caption="BD55-1205, SA55 and VYD222 antibody escape">
    <Altair :showShadow="true" :spec-url="'htmls/antibody_escape_faceted.html'"></Altair>
</Figure>

### BD55-1205
Below is a similar heatmap just showing escape from BD55-1205; click [here](htmls/mAb_BD55-1205_mut_effect.html){target="_self"} for a standalone link:

<Figure caption="BD55-1205 antibody escape">
    <Altair :showShadow="true" :spec-url="'htmls/mAb_BD55-1205_mut_effect.html'"></Altair>
</Figure>

### SA55
Below is a similar heatmap just showing escape from SA55; click [here](htmls/mAb_SA55_mut_effect.html){target="_self"} for a standalone link:

<Figure caption="SA55 antibody escape">
    <Altair :showShadow="true" :spec-url="'htmls/mAb_SA55_mut_effect.html'"></Altair>
</Figure>

### VYD222
Below is a similar heatmap just showing escape from VYD222; click [here](htmls/mAb_VYD222_mut_effect.html){target="_self"} for a standalone link:

<Figure caption="VYD222 antibody escape">
    <Altair :showShadow="true" :spec-url="'htmls/mAb_VYD222_mut_effect.html'"></Altair>
</Figure>


## Interactive structures showing escape

Below are interactive visualizations showing deep mutational scanning data for antibody escape in the context of the RBD protein structure. These visualizations were made using the [dms-viz](https://dms-viz.github.io/dms-viz-docs/) platform. To see antibody escape data overlaid on the RBD, highlight some or all sites on the line plot above the structure. For a better visual under Protein Options on the left set ‘protein representation’ to cartoon and ‘selection representation’ to surface.

### BD55-1205
Click [here](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_BD55-1205.json) for a standalone version of the below plot.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_BD55-1205.json" width="100%" height="500px"></iframe>

### SA55
Click [here](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_SA55.json) for a standalone version of the below plot.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_SA55.json" width="100%" height="500px"></iframe>

### VYD222
Click [here](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_VYD222.json) for a standalone version of the below plot.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FSARS-CoV-2_KP.3.1.1_spike_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fdms-viz_VYD222.json" width="100%" height="500px"></iframe>

## Numerical data
Click [here](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS/blob/main/results/summaries/antibody_escape.csv) for a CSV with the numerical escape values.
