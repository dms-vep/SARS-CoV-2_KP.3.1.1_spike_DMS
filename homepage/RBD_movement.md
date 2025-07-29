---
aside: false
---

# RBD up/down movement

The lineplot below shows the effect each site has on RBD up/down motion. The larger the value the more impact that site has on RBD motion. The effect of each site on RBD up/down conformation is estimated from the deep mutational scanning by calculating correlation (Pearson R) between serum neutralization escape and ACE2 binding for all mutations each site, multiplying that correlation by minus one and weighting it by the root-mean-square (RMS) effect of all mutations at the site on ACE2 binding and the RMS effect of all mutations at the site on serum neutralization escape. Sites with positive correlation had the effect floored to zero. This metric captures the fact that mutations at sites that affect RBD up/down conformation tend to have opposing effects on ACE2 binding and serum neutralization escape. Only sites where binding and neutralization effects could be measured for at least three mutations are shown. More measured mutations at a site as well as more negative correlation coefficient indicates more confident measurement and these parameters can be filtered below the lineplot. 
Note that within each site mutations can have opposing effects, i.e. some may cause RBD to go up, some to go down. The easiest way to see what effect each individual mutation has on RBD motion is to look at ACE2 binding heatmap, if it has positive effect on binding it increases RBD up motion if it has negative effect it leads to RBD being more down.

 

## Mutation effects on RBD up/down motion
<Figure caption="Effects of mutations on  RBD up/down motion">
    <Altair :showShadow="true" :spec-url="'htmls/RBD_up_down_chart_html.html'"></Altair>
</Figure>

## Mutation effects ACE2 binding
<Figure caption="Effects of mutations on  RBD up/down motion">
    <Altair :showShadow="true" :spec-url="'htmls/monomeric_ACE2_mut_effect.html'"></Altair>
</Figure>
