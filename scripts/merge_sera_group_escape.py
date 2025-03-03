import sys

import pandas as pd


sys.stderr = sys.stdout = open(snakemake.log[0], "w")

merged_df = None
for csv in snakemake.input.csvs:
    df = pd.read_csv(csv, usecols=[0, 1, 2, 3])
    if merged_df is None:
        merged_df = df
    else:
        merged_df = merged_df.merge(
            df,
            on=["site", "wildtype", "mutant"],
            how="outer",
            validate="one_to_one",
        )

(
    merged_df
    .query("mutant != wildtype")
    .assign(
        epitope=1,
        times_seen=snakemake.params.times_seen,
        frac_models=snakemake.params.frac_models,
    )
    .to_csv(snakemake.output.csv, index=False, float_format="%.5g")
)
