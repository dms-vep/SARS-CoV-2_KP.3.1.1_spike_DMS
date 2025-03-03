"""Custom rules used in the ``snakemake`` pipeline.

This file is included by the pipeline ``Snakefile``.

"""

rule spatial_distances:
    """Get spatial distances from PDB."""
    input: 
        pdb="data/PDBs/aligned_spike_TM.pdb",
    output:
        csv="results/spatial_distances/spatial_distances.csv",
    params:
        target_chains=["A", "B", "C"],
    log:
        log="results/logs/spatial_distances.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml")
    script:
        "scripts/spatial_distances.py"


# rule merge_sera_group_escape:
#     """Merge filtered escape values for all sera sets from individual group summaries."""
#     input:
#         csvs=[
#             f"results/summaries/{group}.csv"
#             for group in [
#                 "WuhanHu1_imprinted_pre_JN1_vaccination_adult_sera",
#                 "WuhanHu1_imprinted_post_JN1_vaccination_adult_sera",
#             ]
#         ],
#     output:
#         csv="results/summaries/merged_sera_group_escape.csv",        
#     params:
#         times_seen=3,  # set to value used to filter when creating the input summaries
#         frac_models=1,  # set to value used to filter when creating the input summaries
#     log:
#         "results/logs/merge_sera_group_escape.txt",
#     conda:
#         os.path.join(config["pipeline_path"], "environment.yml")
#     script:
#         "scripts/merge_sera_group_escape.py"
