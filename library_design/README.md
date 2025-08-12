# KP.3.1.1 spike mutant library design

This repository selects sites to include in KP.3.1.1 SARS-CoV-2 spike mutant libraries for deep mutational scanning, and then designs oligos to make those mutations using Golden Gate Assembly mutagenesis using the script at [https://github.com/jbloomlab/gga_codon_muts_oligo_design](https://github.com/jbloomlab/gga_codon_muts_oligo_design).

## Input data and configuration
The library design requires the following user-generated input files in [./data/](data):

  - [data/variant_spike.fa](data/variant_spike.fa): the nucleotide sequence of the variant spike for which the library is being designed (in this case, KP.3.1.1), which was manually extracted from the plasmid map in [data/4838_pH2rU3_ForInd_KP.3.1.1_sinobiological_CMV_ZsGT2APurR.gb](data/4838_pH2rU3_ForInd_KP.3.1.1_sinobiological_CMV_ZsGT2APurR.gb)

  - [data/KP311_GAA_assembly_fragments.csv](data/KP311_GAA_assembly_fragments.csv): CSV specifying the tile fragments to add the mutations to for the Golden Gate Assembly mutagenesis. See [https://github.com/jbloomlab/gga_codon_muts_oligo_design](https://github.com/jbloomlab/gga_codon_muts_oligo_design) for an explanation of the format for this file (it is the one passed as `--tiles_csv`).

The library-design also requires the user-generated configuration settings in [config.yaml](config.yaml), which contains all the configuration

## Running and understanding the pipeline

To run the pipeline, build the `conda` environment in [environment.yml](environment.yml), then activate the file and run the `snakemake` pipeline in [Snakefile](Snakefile):

    conda activate spike_library_design
    snakemake -j 1 --software-deployment-method conda
    

The results of running the workflow are then placed in [./results/](results), only some of which are tracked in this GitHub.

The idea behind the design is as follows:

#### Get a mapping of sequential to reference site numbers
We want to refer to residues in reference (Wuhan-Hu-1) numbering.
This is done by aligning the protein we are mutagenizing with the Wuhan-Hu-1 reference genome, to map sequential 1, 2, ... numbering of the protein being used in the experiments to reference numbering.

The file [results/numbering/sequential_to_reference.csv](results/numbering/sequential_to_reference.csv) maps reference to sequential numbering, and the file [results/numbering/mutations_from_reference.csv](results/numbering/mutations_from_reference.csv) gives all the mutations separating the spike used in the experiments from the reference.

#### Get various types of mutation counts
The pipeline gets the counts of mutations in different categories.
Currently these include:
 - Amino-acid counts in a GISAID alignment of all spikes.
 - Mutation counts (occurrences) along UShER tree
 - Mutation counts (occurrences) along UShER tree just for recent clades
 - Amino-acid mutations observed in a designated Pango lineage
 - Mutations that differ between the variant and reference

The [config.yaml](config.yaml) specifies exactly how we obtain these counts.

#### Design mutations to make
We use the counts of the different amino acid mutations along with thresholds specified in [config.yaml](config.yaml) to identify mutations to make as well as sites to saturate (make all possible mutations).
Single-residue deletions and stop-codon mutations are only included if specified in [config.yaml](config.yaml).
We also determine a *representation* for each mutation, which corresponds to how many of the different count thresholds it meets.

These results are recorded in [results/mutations_to_make.csv](results/mutations_to_make.csv).
The interactive HTML chart [results/mutations_to_make.html](results/mutations_to_make.html) (which must be downloaded and opened in a browser to view) provides some statistics on how many mutations are made.

#### Make oligos for Golden-Gate assembly mutagenesis
A script downloaded from [https://github.com/jbloomlab/gga_codon_muts_oligo_design](https://github.com/jbloomlab/gga_codon_muts_oligo_design)
is used to make the actual oligos.
Additional command line arguments to the script are specified in [config.yaml](config.yaml).

The final designed oligos are in [results/mutagenesis_oligos.fa](results/mutagenesis_oligos.fa).

[data/prmers.fa](data/primers.fa) contains a list of primers used to amplify tiles and flanking spike sequences from ssDNA pool and [data/4838_pH2rU3_ForInd_KP.3.1.1_sinobiological_CMV_ZsGT2APurR.gb](data/4838_pH2rU3_ForInd_KP.3.1.1_sinobiological_CMV_ZsGT2APurR.gb) backbone.

