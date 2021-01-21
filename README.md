# 2021-snakemake-checkpoints-example

This is an example Snakefile that constructs a dynamic number of files
"output-{n}.txt", based on the current hour of the day plus 2.

So, for example, if it's 6am, it will create output files
"output-1.txt" through "output-8.txt".

To run:

```
snakemake -j 1 make_all_files
```
