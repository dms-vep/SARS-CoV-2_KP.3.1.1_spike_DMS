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


rule compare_binding:
    """Compare ACE2 binding across datasets."""
    input:
        KP311_spike_csv="results/summaries/all_adult_sera_escape.csv",
        nb="notebooks/compare_binding.ipynb",
    params:
        yaml=lambda wc, input: yaml_str(
            {
                # ----------------------------------------
                # parameters for plots
                # ----------------------------------------
                "init_min_func_effect": -2,
                "clip_binding_upper": 4,
                "clip_binding_lower": -6,
                # ----------------------------------------
                # Other deep mutational scanning datasets
                # ----------------------------------------
                # XBB.1.5 in spike DMS in lentiviral system
                "XBB_spike_csv":
                    "https://raw.githubusercontent.com/dms-vep/SARS-CoV-2_XBB.1.5_spike_DMS/refs/heads/main/results/summaries/summary.csv",
            }
            | {key: val for (key, val) in dict(input).items() if key != "nb"}
        ),
    output:
        merged_binding_csv="results/binding_comparison/merged_binding.csv",
        nb="results/notebooks/compare_binding.ipynb",
        binding_corr="results/binding_comparison/binding_corr.html",
        binding_dist="results/binding_comparison/binding_dist.html",
        binding_entry_corr="results/binding_comparison/binding_entry_corr.html",
        binding_escape_corr="results/binding_comparison/binding_ecape_corr.html",
    log:
        log="results/logs/compare_binding.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml")
    shell:
        """
        papermill {input.nb} {output.nb} \
            -y '{params.yaml}' \
            -p merged_binding_csv {output.merged_binding_csv} \
            -p binding_corr_html {output.binding_corr} \
            -p binding_dist_html {output.binding_dist} \
            -p binding_entry_corr_html {output.binding_entry_corr} \
            -p binding_escape_corr_html {output.binding_escape_corr} \
            &> {log}
        """

rule func_effects_dist:
    """Distribution of functional effects and correlation with natural sequences."""
    input:
        KP311_func_effects_csv="results/func_effects/averages/293T_high_ACE2_entry_func_effects.csv",
        site_numbering_map_csv=config["site_numbering_map"],
        nb="notebooks/func_effects_dist.ipynb",
    output:
        strain_corr="results/func_effects_analyses/strain_corr.html",
        effects_boxplot="results/func_effects_analyses/effects_boxplot.html",
        key_muts_plot="results/func_effects_analyses/key_mutations.html",
        nb="results/notebooks/func_effects_dist.ipynb",
    params:
        yaml=lambda _, input, output: yaml_str(
            {
                "KP311_func_effects_csv": input.KP311_func_effects_csv,
                "XBB_func_effects_csv":
                    "https://raw.githubusercontent.com/dms-vep/SARS-CoV-2_XBB.1.5_spike_DMS/refs/heads/main/results/func_effects/averages/293T_medium_ACE2_entry_func_effects.csv",
                "site_numbering_map_csv": input.site_numbering_map_csv,
                "init_min_times_seen": 2,
                "init_min_n_libraries": 2,
                "max_effect_std": 1.6,
                "key_mutations": ["T22N", "K182R","G184S", "F186L","R190S", "A435S", "N487D"],
                "strain_corr_html": output.strain_corr,
                "effects_boxplot_html": output.effects_boxplot,
                "key_muts_html": output.key_muts_plot,
            }
        ),
    log:
        "results/logs/func_effects_dist.txt",
    shell:
        "papermill {input.nb} {output.nb} -y '{params.yaml}' &>> {log}"


# Files (Jupyter notebooks, HTML plots, or CSVs) that you want included in
# the HTML docs should be added to the nested dict `docs`:
docs["Additional files and charts"] = {
    "Comparison of escape pre and post vaccination": {
        "Interactive chart comparing escape":
            rules.compare_pre_post_escape.output.chart,
    },
    "Analysis of ACE2 binding data and comparison to other experiments": {
        "Interactive binding data charts": {
            "Correlations among experiments":
                rules.compare_binding.output.binding_corr,
            "Distribution of RBD and non-RBD ACE2 binding":
                rules.compare_binding.output.binding_dist,
            "Correlation of ACE2 binding to viral entry":
                rules.compare_binding.output.binding_entry_corr,
            "Correlation of ACE2 binding to viral escape":
                rules.compare_binding.output.binding_escape_corr,
        },
        "CSV of ACE2 binding from different experiments":
            rules.compare_binding.output.merged_binding_csv,
    },
    "Analysis of mutational effects on cell entry": {
        "Interactive entry data charts": {
            "Correlation of cell entry effects among strains":
                rules.func_effects_dist.output.strain_corr,
            "Distribution of cell entry effects":
                rules.func_effects_dist.output.effects_boxplot,
            "Effects of key mutations on cell entry":
                rules.func_effects_dist.output.key_muts_plot,
        },
    },    
}