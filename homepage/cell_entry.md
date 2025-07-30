---
aside: false
---

# Cell Entry in 293T-ACE2 cells

This page has data about how mutations to the KP.3.1.1 spike affect pseudovirus entry in 293T cells expressing medium levels of ACE2 (see [this paper](https://www.mdpi.com/1999-4915/14/9/2061) for details on those cells).
You can view and access these data in several ways:


[[toc]]

## Interactive heatmap of mutation effects on cell entry
The heatmap below shows effects of mutations to the KP.3.1.1 spike on entry in ACE2-expressing cells.
Effects greater than zero (blue) indicate a mutation improves cell entry while effects less than zero (orange) indicate a mutation impairs cell entry. X indicates the wild-type amino acid in KP.3.1.1.
Light grey indicates mutations for which effects were not measured in our libraries; note that our library design excluded most mutations expected to be highly deleterious from all regions of the spike except for the RBD. 
You can also mouseover points for details on the measurements in each library replicate, and use the options at the bottom of the plot to adjust various filtering and display options.

Click [here](htmls/293T_medium_ACE2_entry_func_effects.html){target="_self"} for a standalone link to the heatmap shown below.

<Figure caption="Effects of mutations on entry in 293T cells expressing ACE2">
    <Altair :showShadow="true" :spec-url="'htmls/293T_medium_ACE2_entry_func_effects.html'"></Altair>
</Figure>

## Numerical values for cell entry measurements
For the measured effects of mutations on entry after filtering and averaging across replicates, see the *spike mediated entry* column of [this CSV](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS/blob/main/results/summaries/antibody_escape.csv).
For non-filtered values, see [this CSV](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS/blob/main/results/func_effects/averages/293T_medium_ACE2_entry_func_effects.csv).
