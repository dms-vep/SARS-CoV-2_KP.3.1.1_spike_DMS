#!/bin/bash
#
#SBATCH -c 4

snakemake -j 4 --rerun-incomplete --use-conda -s dms-vep-pipeline-3/Snakefile
