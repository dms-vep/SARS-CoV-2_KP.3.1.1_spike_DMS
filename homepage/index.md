---
layout: home

hero:
  name: Deep mutational scanning of spike from KP.3.1.1 SARS-CoV-2 strain
  tagline: Interactive visualizations of effects of mutations on different KP.3.1.1 spike phenotypes
  image: DMS.png
features:
  - title: Cell entry
    details: Effects of mutations on entry into 293T-ACE2 cells
    link: /cell_entry
  - title: Polyclonal sera escape
    details: Mutations effects on neutralization by human sera before and after JN.1* spike exposure
    link: /polyclonal_sera_escape
  - title: Monoclonal antibody escape
    details: Mutation effects on neutralization by the BD55-1205, SA55 and VYD222 monoclonal antibodies
    link: /antibody_escape
  - title: Receptor binding
    details: Mutation effects on full-spike ACE2 binding
    link: /receptor_binding
  - title: RBD up/down conformation
    details: Sites that regulate RBD up/down conformation
    link: /RBD_movement
---

This page provides access to interactive visualizations of the effects of mutations to the spike of the KP.3.1.1 strain of SARS-CoV-2 as measured using [pseudovirus deep mutational scanning](https://www.sciencedirect.com/science/article/pii/S0092867423001034).
The study that generated these data is detailed in [Dadonaite et al (2025)](https://www.biorxiv.org/content/10.1101/2025.08.18.671001v1), which is also the citation for these data.

The measurements were all made using non-replicative lentiviral pseudotyped particles ("pseudoviruses") that are not infectious pathogens capable of causing disease, and so provide a safe way to study the impact of mutations to SARS-CoV-2 proteins.

The links in the gray boxes above take you to pages with details about the experimental measurements of the effects of mutations on different spike phenotypes, as well as interactive visualizations and links to the numerical measurements for each mutation.

For the full computer code and numerical results, see the GitHub repo at [https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS](https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS).
For full documentation of the analysis pipeline, see the [Appendix](appendix.html){target="_self"}.
