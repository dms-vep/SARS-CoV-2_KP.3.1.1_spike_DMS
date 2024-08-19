# KP.3.1.1 spike mutant library design

This repository selects sites to include in KP.3.1.1 SARS-CoV-2 spike mutant libraries for deep mutational scanning

## Design workflow

To run the workflow, build the `conda` environment in [environment.yml](environment.yml), then activate the file and run the `snakemake` pipeline in [Snakefile](Snakefile):

    conda activate spike_library_design
    snakemake -j 1
    

[./data](data) includes KP.3.1.1 spike sequence and lentiviral DMS vector into which this spike will be cloned. [./data/sequential_to_reference.csv](data/sequential_to_reference.csv) contains KP.3.1.1 spike sequential and reference numbering scemes. 

The results of running the workflow are then placed in [./results/](results).

The configuration for the workflow is in [config.yaml](config.yaml), input data are in [./data/](data), the scripts are in [./scripts/](scripts), and Jupyter notebooks are in [./notebooks/](notebooks).

The idea behind the design is as follows:

#### Specify the gene to mutagenize
We need the sequence of the gene to mutagenize.
Because we are designing primers that may extend outside the gene, this needs to be an "extended" sequence that also includes some upstream and downstream flanking.
A FASTA file containing the gene to mutagenize is specified via the `extended_gene` key in [config.yaml](config.yaml).
In that file, the gene sequence to be mutagenized should be in uppercase letters and flanking sequence not to be mutagenized should be in lower-case letters.

For instance, the gene that would be used for a XBB.1.5 full-spike library is in [data/extended_spike_XBB.1.5.fa](data/extended_spike_XBB.1.5.fa).

#### Get a mapping of sequential to reference site numbers
We want to refer to residues in reference (Wuhan-Hu-1) numbering.
This is done by aligning the protein we are mutagenizing with the Wuhan-Hu-1 reference specified under the `reference_gene` key in [config.yaml](config.yaml).
In this case, that file is [data/reference_spike.fa](data/reference_spike.fa).

The pipeline builds the site-numbering mapping, which is in [results/sequential_to_reference.csv](results/sequential_to_reference.csv).

#### Get GISAID alignment counts and UShER mutation counts
The pipeline gets the total counts of each non-reference amino-acid at each site in GISAID sequences from [here](https://mendel.bii.a-star.edu.sg/METHODS/corona/current/MUTATIONS/hCoV-19_Human_2019_WuhanWIV04/hcov19_Spike_mutations_table.html).

The pipeline also counts the number of unique occurrences on the tree (number of substitutions, not alignment counts) of each amino-acid mutation from the pre-built UShER tree.
These UShER mutation counts are done both for all SARS-CoV-2 clades, and for just the "recent" clades specified under `usher_recent_clades` in [config.yaml](config.yaml).

Information about the GISAId alignment counts, the overall UShER mutation counts, and the recent-clade UShER mutation counts is aggregated by the pipeline in the file [results/mutation_stats.csv](results/mutation_stats.csv).

#### Identify mutations to target and sites to saturate
The pipeline then identifies the mutations to target, as follows:

 1. Any mutation with counts >= any of the thresholds in the GISAID or UShER data listed under the `mutation_retain_thresholds` key in [config.yaml](config.yaml). However, deletion mutations are only included if they meet the counts **and** are in the range(s) specified under the `sites_to_allow_deletions` key in [config.yaml](config.yaml).
 2. Any mutation listed explicitly in `mutations_to_include` key in [config.yaml](config.yaml).
 3. All amino-acid and stop mutations at sites in `sites_to_saturate`. (Therefore, any mutation specified at a site to saturate is also a targeted mutation).
 
The pipeline writes the mutations to target to [results/targeted_mutations.csv](results/targeted_mutations.csv).
 
The sites to saturate are identified as follows:

  1. Any site with total mutation counts >= any of the thresholds specified under the `sites_to_allow_deletions` key in [config.yaml](config.yaml).
  2. All sites that differ between the sequence being mutagenized and the "reference" (eg, Wuhan-Hu-1 sequence) if the `saturate_diffs_from_reference` key in [config.yaml](config.yaml).
  3. All sites explicitly listed under the `sites_to_saturate` key in [config.yaml](config.yaml). This includes all postions in the RBD.
 
The pipeline writes the sites to saturate to [results/saturated_sites.csv](results/saturated_sites.csv).

Some mutations are added manually
  1. Saturate 16_MPLF insertion site. These are listed added to the [saturated_sites.csv](results/saturated_sites.csv) and are listed in [data/insertion_sites.csv](data/insertion_sites.csv)

The number of targeted mutations and saturated sites as a function of the parameters is shown in the interactive plot at [results/mutations_to_make.html](results/mutations_to_make.html).

#### Gibsom assembly

17 fragments that cover KP.3.1.1 spike for golden gate assembly are listed in [data/KP311_GAA_assembly_fragments.csv](data/KP311_GAA_assembly_fragments.csv). The columns in this file are as folows:

  1. `fragment`: fragment number
  2. `fragment_sequence`: full tile sequence to be ordered in the oligo pool. This covers unmutated parts where primers will be algning
  3. `inframe_mutated_region`: sequence that will be mutated. These sequences are all in frame, i.e. first codon in the first frame is the forst one to be mutated
  4. `start_site` and `end_site`: start and end site in spike for mutated region in each tile. This uses sequential spike numbering.
