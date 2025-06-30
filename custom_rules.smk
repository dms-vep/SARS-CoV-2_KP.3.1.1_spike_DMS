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


rule compare_pre_post_escape:
    """Compare escape pre and post vaccination or infetion"""
    input:
        escape=expand(
            rules.avg_escape.output.effect_csv,
            assay=["antibody_escape"],
            antibody=avg_assay_config["antibody_escape"],
        ),
        site_numbering_map=config["site_numbering_map"],
        func_effects="results/func_effects/averages/293T_high_ACE2_entry_func_effects.csv",
        nb="notebooks/compare_pre_post_escape.ipynb",
    output:
        chart="results/escape_comparisons/compare_pre_post_escape.html",
        nb="results/notebooks/compare_pre_post_escape.ipynb",
    params:
        yaml=lambda wc, input: yaml_str(
            {
                "init_min_func_effect": -3,
                "max_effect_std": 1,
                "init_min_times_seen": 2,
                "init_floor_at_zero": False,
                "init_site_escape_stat": "sum",
                "escape_csvs": list(input.escape),
            }
        ),
    log:
        log="results/logs/compare_pre_post_escape.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml")
    shell:
        """
        papermill {input.nb} {output.nb} \
            -y '{params.yaml}' \
            -p site_numbering_map_csv {input.site_numbering_map} \
            -p func_effects_csv {input.func_effects} \
            -p chart_html {output.chart} \
            &> {log}
        """

rule merge_sera_group_escape:
    """Merge filtered escape values for all sera sets from individual group summaries."""
    input:
        csvs=[
            f"results/summaries/{group}.csv"
            for group in [
                "pre_infection",
                "post_infection",
                "pre_vaccination",
                "post_vaccination",
            ]
        ],
    output:
        csv="results/summaries/merged_sera_group_escape.csv",        
    params:
        times_seen=2,  # set to value used to filter when creating the input summaries
        frac_models=0.5,  # set to value used to filter when creating the input summaries
    log:
        "results/logs/merge_sera_group_escape.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml")
    script:
        "scripts/merge_sera_group_escape.py"



# Files (Jupyter notebooks, HTML plots, or CSVs) that you want included in
# the HTML docs should be added to the nested dict `docs`:
docs["Additional files and charts"] = {
    "Comparison of escape pre and post vaccination": {
        "Interactive chart comparing escape":
            rules.compare_pre_post_escape.output.chart,
    },
}