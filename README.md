# 2021-snakemake-checkpoints-example

This is an example Snakefile that constructs a dynamic number of files
"output-{n}.txt", based on the current hour of the day plus 2.

So, for example, if it's 6am, it will create output files
"output-1.txt" through "output-8.txt".

The key point is that the number of output files is unknown at the beginning
of the snakemake run, so snakemake must figure it out dynamically. Here,
I use checkpoints to make that happen.

To run:

```
snakemake -j 1 make_all_files
```

## A second example

See `Snakefile.random`, and run it like so:

```
snakemake -s Snakefile.random make_all_files -j 1
```
