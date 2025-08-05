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
        func_effects="results/func_effects/averages/293T_medium_ACE2_entry_func_effects.csv",
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
                "pre_vaccination_infection",
                "post_vaccination_infection",
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
                "binding_mut_scatter_sites": [435, 493],
                # ----------------------------------------
                # Other deep mutational scanning datasets
                # ----------------------------------------
                # XBB.1.5 in full spike and RBD-only DMS in lentiviral system
                "XBB_spike_csv":
                    "https://raw.githubusercontent.com/dms-vep/SARS-CoV-2_XBB.1.5_spike_DMS/refs/heads/main/results/summaries/summary.csv",
                "XBB_RBD_csv":
                    "https://raw.githubusercontent.com/dms-vep/SARS-CoV-2_XBB.1.5_RBD_DMS/refs/heads/main/results/summaries/summary.csv",   
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
        binding_mut_scatter="results/binding_comparison/binding_mut_scatter.html",
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
            -p binding_mut_scatter_html {output.binding_mut_scatter} \
            &> {log}
        """

rule func_effects_dist:
    """Distribution of functional effects and correlation with natural sequences."""
    input:
        KP311_func_effects_csv="results/func_effects/averages/293T_medium_ACE2_entry_func_effects.csv",
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


rule mutation_binding_effects:
    """compare mutation effects on ACE2 bidning between libraries"""
    input:
        binding_effects_csv = 'results/ACE2_binding/averages/monomeric_ACE2_mut_effect.csv',
        site_numbering_map_csv=config["site_numbering_map"],
        entry_effects_csv = 'results/func_effects/averages/293T_medium_ACE2_entry_func_effects.csv',
        nb="notebooks/mutation_binding_effects.ipynb",
    output:
        library_binding_corr = "results/func_effects_analyses/library_binding_corr_html.html",
        distance_library_binding_corr = "results/func_effects_analyses/distance_library_binding_corr_html.html",
        nb="results/notebooks/mutation_binding_effects.ipynb",
    params:
        yaml=lambda _, input, output: yaml_str(
            {
                "binding_effects_csv": input.binding_effects_csv,
                "entry_effects_csv": input.entry_effects_csv,
                "site_numbering_map_csv": input.site_numbering_map_csv,
                "init_min_times_seen": 2,
                "init_min_n_libraries": 2,
                "init_binding_std" : 1.8,
                "library_binding_corr": output.library_binding_corr,
                "distance_library_binding_corr": output.distance_library_binding_corr,
            }
        ),
    log:
        "results/logs/mutation_binding_effects.txt",
    shell:
        "papermill {input.nb} {output.nb} -y '{params.yaml}' &>> {log}"


rule binding_vs_escape:
    """Compare binding and escape at key sites."""
    input:
        dms_csv="results/summaries/all_adult_sera_escape.csv",
        nb="notebooks/binding_vs_escape.ipynb",
    output:
        nb="results/notebooks/binding_vs_escape.ipynb",
        RBD_up_down_chart_html = "results/binding_vs_escape/RBD_up_down_chart_html.html",
        logoplot_subdir=directory("results/binding_vs_escape/logoplots"),
        RBD_up_down_subdir=directory("results/RBD_up_down"),
        RBD_up_down_csv = "results/RBD_up_down/RBD_up_down_sites.csv",
    params:
        yaml=lambda _, input, output: yaml_str(
            {
                "dms_csv": input.dms_csv,
                "logoplot_subdir": output.logoplot_subdir,
                "RBD_up_down_subdir": output.RBD_up_down_subdir,
                "min_cell_entry": -2,
                "min_mutations_at_site": 5,
                "RBD_up_down_chart_html": output.RBD_up_down_chart_html,
                "RBD_up_down_csv": output.RBD_up_down_csv,
            }
        ),
    log:
        log="results/logs/binding_vs_escape.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml")
    shell:
        "papermill {input.nb} {output.nb} -y '{params.yaml}' &> {log}"



rule escape_logos:
    """Make logo plots for each antibody"""
    input:
        per_antibody_escape = "results/summaries/antibody_escape.csv",
    output:
        BD55_1205_svg = "results/escape_logos/BD55-1205_spike_DMS_line_logo_plot.svg",
        SA55_svg = "results/escape_logos/SA55_spike_DMS_line_logo_plot.svg",
        VYD222_svg = "results/escape_logos/VYD222_spike_DMS_line_logo_plot.svg",
        BD55_1205_JN1_Cao = "results/escape_logos/BD55-1205_JN.1_RBD_line_logo_plot.svg",
        SA55_JN1_Cao = "results/escape_logos/SA55_JN.1_RBD_line_logo_plot.svg",
        VYD222_JN1_Cao = "results/escape_logos/VYD222_JN.1_RBD_line_logo_plot.svg",
    log:
        notebook = "results/logs/escape_logoplots_for_key_sites.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    notebook:
        "notebooks/escape_logoplots_for_key_sites.py.ipynb"


rule configure_dms_viz_sera:
    """Configure a JSON file for `dms-viz`."""
    input:
        phenotypes_csv="results/summaries/sera_group_averages.csv",
        site_numbering_map=config["site_numbering_map"],
        nb="notebooks/configure_dms_viz_sera.ipynb",
    output:
        dms_viz_json="results/dms-viz/dms-viz_sera.json",
        dms_viz_phenotypes="results/dms-viz/phenotypes_sera.csv",
        pdb_file="results/dms-viz/pdb_file.pdb",
        nb="results/notebooks/configure_dms_viz_sera.ipynb",
    params:
        dms_viz_subdir=lambda _, output: os.path.dirname(output.dms_viz_json),
        pdb_id="9ELJ",  # JN.1.11+Q493E+S31 structure
        chains="A,B,C",  # chains in the PDB to color
    log:
        "results/logs/configure_dms_viz_sera.txt",
    conda:
        "envs/dms-viz.yml"
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p phenotypes_csv {input.phenotypes_csv} \
            -p site_numbering_map {input.site_numbering_map} \
            -p dms_viz_json {output.dms_viz_json} \
            -p dms_viz_phenotypes {output.dms_viz_phenotypes} \
            -p pdb_file {output.pdb_file} \
            -p dms_viz_subdir {params.dms_viz_subdir} \
            -p pdb_id {params.pdb_id} \
            -p chains {params.chains} \
            &> {log}
        """

rule configure_dms_viz_SA55:
    """Configure a JSON file for `dms-viz`."""
    input:
        phenotypes_csv="results/summaries/antibody_escape.csv",
        site_numbering_map=config["site_numbering_map"],
        nb="notebooks/configure_dms_viz_SA55.ipynb",
    output:
        dms_viz_json="results/dms-viz/dms-viz_SA55.json",
        dms_viz_phenotypes="results/dms-viz/phenotypes_SA55.csv",
        pdb_file="results/dms-viz/pdb_file_SA55.pdb",
        nb="results/notebooks/configure_dms_viz_SA55.ipynb",
    params:
        dms_viz_subdir=lambda _, output: os.path.dirname(output.dms_viz_json),
        pdb_id="7Y0W",  # SA55+RBD
        chains="R",  # chains in the PDB to color
    log:
        "results/logs/configure_dms_viz_SA55.txt",
    conda:
        "envs/dms-viz.yml"
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p phenotypes_csv {input.phenotypes_csv} \
            -p site_numbering_map {input.site_numbering_map} \
            -p dms_viz_json {output.dms_viz_json} \
            -p dms_viz_phenotypes {output.dms_viz_phenotypes} \
            -p pdb_file {output.pdb_file} \
            -p dms_viz_subdir {params.dms_viz_subdir} \
            -p pdb_id {params.pdb_id} \
            -p chains {params.chains} \
            &> {log}
        """

rule configure_dms_viz_BD55_1205:
    """Configure a JSON file for `dms-viz`."""
    input:
        phenotypes_csv="results/summaries/antibody_escape.csv",
        site_numbering_map=config["site_numbering_map"],
        nb="notebooks/configure_dms_viz_BD55-1205.ipynb",
    output:
        dms_viz_json="results/dms-viz/dms-viz_BD55-1205.json",
        dms_viz_phenotypes="results/dms-viz/phenotypes_BD55-1205.csv",
        pdb_file="results/dms-viz/pdb_file_BD55-1205.pdb",
        nb="results/notebooks/configure_dms_viz_BD55-1205.ipynb",
    params:
        dms_viz_subdir=lambda _, output: os.path.dirname(output.dms_viz_json),
        pdb_id="8XE9",  # BD55-1205+RBD
        chains="C",  # chains in the PDB to color
    log:
        "results/logs/configure_dms_viz_BD55-1205.txt",
    conda:
        "envs/dms-viz.yml"
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p phenotypes_csv {input.phenotypes_csv} \
            -p site_numbering_map {input.site_numbering_map} \
            -p dms_viz_json {output.dms_viz_json} \
            -p dms_viz_phenotypes {output.dms_viz_phenotypes} \
            -p pdb_file {output.pdb_file} \
            -p dms_viz_subdir {params.dms_viz_subdir} \
            -p pdb_id {params.pdb_id} \
            -p chains {params.chains} \
            &> {log}
        """

rule configure_dms_viz_VYD222:
    """Configure a JSON file for `dms-viz`."""
    input:
        phenotypes_csv="results/summaries/antibody_escape.csv",
        site_numbering_map=config["site_numbering_map"],
        nb="notebooks/configure_dms_viz_VYD222.ipynb",
    output:
        dms_viz_json="results/dms-viz/dms-viz_VYD222.json",
        dms_viz_phenotypes="results/dms-viz/phenotypes_VYD222.csv",
        pdb_file="results/dms-viz/pdb_file_VYD222.pdb",
        nb="results/notebooks/configure_dms_viz_VYD222.ipynb",
    params:
        dms_viz_subdir=lambda _, output: os.path.dirname(output.dms_viz_json),
        pdb_id="7U2D",  # ADG20+RBD
        chains="A",  # chains in the PDB to color
    log:
        "results/logs/configure_dms_viz_VYD222.txt",
    conda:
        "envs/dms-viz.yml"
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p phenotypes_csv {input.phenotypes_csv} \
            -p site_numbering_map {input.site_numbering_map} \
            -p dms_viz_json {output.dms_viz_json} \
            -p dms_viz_phenotypes {output.dms_viz_phenotypes} \
            -p pdb_file {output.pdb_file} \
            -p dms_viz_subdir {params.dms_viz_subdir} \
            -p pdb_id {params.pdb_id} \
            -p chains {params.chains} \
            &> {log}
        """

# Files (Jupyter notebooks, HTML plots, or CSVs) that you want included in
# the HTML docs should be added to the nested dict `docs`:
docs["Additional files and charts"] = {
    "Comparison of escape pre and post vaccination": {
        "Interactive chart comparing escape":
            rules.compare_pre_post_escape.output.chart,
    },
    "Analysis of ACE2 binding data and comparison to other experiments": {
        "Interactive binding data charts": {
            "Correlations among library ACE2 binding measurements":
                rules.mutation_binding_effects.output.library_binding_corr,
            "Correlations among library binding measurements by distance from ACE2":
                rules.mutation_binding_effects.output.distance_library_binding_corr,
           "Correlations among experiments for key sites":
                rules.compare_binding.output.binding_mut_scatter,
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
    "Notebook comparing binding vs escape at key sites": rules.binding_vs_escape.output.nb,
    "Sites that affect RBD up/down conformation": rules.binding_vs_escape.output.RBD_up_down_chart_html,
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

other_target_files.append([
    rules.escape_logos.output.BD55_1205_svg,
    rules.escape_logos.output.SA55_svg,
    rules.escape_logos.output.VYD222_svg,
    rules.escape_logos.output.VYD222_JN1_Cao,
    rules.configure_dms_viz_sera.output.dms_viz_json,
    rules.configure_dms_viz_SA55.output.dms_viz_json,
    rules.configure_dms_viz_BD55_1205.output.dms_viz_json,
    rules.configure_dms_viz_VYD222.output.dms_viz_json,
     ] )
