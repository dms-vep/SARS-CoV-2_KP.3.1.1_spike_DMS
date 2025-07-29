---
aside: false
---

# Receptor binding

We have mapped how mutations in spike affect ACE2 binding. We use soluble monomeric ACE2 in our assay. Previous research has shown that ACE2 binding affinity to spike is proportional to neutralization of SARS-CoV-2 pseudovirus by soluble ACE2 protein. Note, our assay measures binding to ACE2 in a full spike context, which is impacted by several distinct mechanisms: direct interaction of the RBD with ACE2, changes in RBD up (open) or down (closed) conformation, and changes to S1 shedding.

The plot below is interactive, and allows you to zoom and mouseover sites and mutations. Click on the expansion box in the upper right of the plot to enlarge it for easier viewing. Note that the two different shades of gray in the heatmaps have differing meanings: light gray means a mutation was missing (not measured) in the library, whereas dark gray means a mutation was measured but was so deleterious for cell entry it is not possible to reliably estimate its effect on other phenotypes (the threshold for how deleterious a mutation must be for cell entry to be shown in dark gray is controlled by the cell entry slider at the bottom of the plot). 
 
## Effects of mutations on ACE2 bidning
<Figure caption="Effects of mutations on ACE2 bidning">
    <Altair :showShadow="true" :spec-url="'htmls/monomeric_ACE2_mut_effect.html'"></Altair>
</Figure>
