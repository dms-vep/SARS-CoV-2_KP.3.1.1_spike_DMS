---
aside: false
---

# Full spike ACE2 receptor binding

We measured how mutations affect binding of the full KP.3.1.1 spike to ACE2, using neutralization of pseudovirus by soluble ACE2 as a proxy for full spike binding.
Note that mutations to the spike can affect ACE2 binding either by affecting the 1:1 RBD:ACE2 affinity, by modulating RBD up/down conformation in the context of the full spike (see [here](/RBD_movement) for more on this), or by affecting S1 shedding.

You can explore these data as follows:
[[toc]]

## Interactive heatmap of effects of mutations on ACE2 binding

In the interactive chart below, the line plot shows the total effects of mutations at each site, and the heatmap shows the effects of individual mutations.
Click [here](htmls/monomeric_ACE2_mut_effect.html){target="_self"} for a standalone version of this plot.
Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot). 
 
<Figure caption="Effects of mutations on ACE2 binding">
    <Altair :showShadow="true" :spec-url="'htmls/monomeric_ACE2_mut_effect.html'"></Altair>
</Figure>

## Correlation between libraries for different sets of mutation
See the chart below (standalone version [here](htmls/distance_library_binding_corr_html.html){target="_self"}) the correlation between mutations effects on ACE2 binding measured in the different library replicates for ACE2-proximal RBD sites, ACE2-distal RBD sites, and non-RBD sites:

<Figure caption="Effects of mutations on ACE2 binding">
    <Altair :showShadow="true" :spec-url="'htmls/distance_library_binding_corr_html.html'"></Altair>
</Figure>

## Correlation between mutation effects in KP.3.1.1 spike and XBB.1.5 spike
See the chart below (standalone version [here](htmls/binding_corr.html){target="_self"}) for a correlation between mutations effects on ACE2 binding in the KP.3.1.1 spike and effects in the XBB.1.5 spike measured in one of our prior studies ([Dadonaite et al (2024)](https://www.nature.com/articles/s41586-024-07636-1)).

<Figure caption="Effects of mutations on ACE2 binding">
    <Altair :showShadow="true" :spec-url="'htmls/binding_corr.html'"></Altair>
</Figure>

## Numerical values
See the *ACE2 binding* column of [this CSV](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS/blob/main/results/summaries/all_adult_sera_escape.csv) for filtered values of the measurements of effects on ACE2 binding.
See [this CSV](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS/blob/main/results/ACE2_binding/averages/monomeric_ACE2_mut_effect.csv) for the measurements without filtering.
