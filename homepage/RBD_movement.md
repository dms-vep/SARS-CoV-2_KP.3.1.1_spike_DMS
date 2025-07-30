---
aside: false
---

# Sites that affect RBD up/down conformation

The receptor binding domain of spike (RBD) undergoes a dynamic motion of up down movement. This is required for the RBD to interact with the ACE2 receptor, which is primarily accessible only when the RBD is up. But having RBD in the up also exposes spike to neutralization by some of the post potent antibodies in sera that compete with receptor binding. Mutations throughout the spike can control this up/down motion. 

The lineplot below shows the estimated effect each site has on RBD up/down motion (click [here](htmls/RBD_up_down_chart_html.html){target="_self"} for a standalone link to this plot). The larger the value the more impact that mutations at that site are estimated to have on RBD motion. 

The effect of each site on RBD up/down conformation is estimated from the deep mutational scanning by calculating correlation (Pearson R) between serum neutralization escape and ACE2 binding for all mutations each site, multiplying that correlation by minus one and weighting it by the root-mean-square (RMS) effect of all mutations at the site on ACE2 binding and the RMS effect of all mutations at the site on serum neutralization escape. Sites with positive correlation had the effect floored to zero. This metric captures the fact that mutations at sites that affect RBD up/down conformation tend to have opposing effects on ACE2 binding and serum neutralization escape. Only sites where binding and neutralization effects could be measured for at least three mutations are shown. Sites where more mutations where measured and where correlation is more negative have better measurement confidence and these parameters can be filtered below the lineplot. 

Note that within each site mutations can have opposing effects, i.e. some may cause RBD to go up, some to go down. The easiest way to see what effect each individual mutation has on RBD motion is to look at [ACE2 binding heatmap](/receptor_binding): if it has positive effect on binding it increases RBD up motion if it has negative effect it leads to RBD being more down.

<Figure caption="Effects of mutations on  RBD up/down motion">
    <Altair :showShadow="true" :spec-url="'htmls/RBD_up_down_chart_html.html'"></Altair>
</Figure>
