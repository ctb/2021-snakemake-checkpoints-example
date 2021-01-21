import time

# first rule: record the current time, save it to a file.
rule save_time:
    output: "count.txt"
    run:
        t = time.localtime()
        with open(str(output), 'wt') as fp:
            print(t.tm_hour + 2, file=fp)

# second rule, a checkpoint for rules that depend on contents of "count.txt"
checkpoint check_count:
    input: "count.txt"
    output:
        touch(".make_files.touch")

# third rule: make a file 'output-{n}.txt'
rule make_file:
    output:
        "output-{n}.txt"
    shell:
        "echo hello, world > {output}"

# checkpoint code to read count and specify all the outputs
class Checkpoint_MakePattern:
    def __init__(self, pattern):
        self.pattern = pattern

    def get_count(self):
        with open('count.txt', 'rt') as fp:
            count = int(fp.read().strip())
        return count

    def __call__(self, w):
        global checkpoints

        # wait for the results of 'check_counts'; this will trigger an
        # exception until that rule has been run.
        checkpoints.check_count.get(**w)

        count = self.get_count()
        nums = range(1, count + 1)

        pattern = expand(self.pattern, n=nums, **w)
        return pattern

rule make_all_files:
    input:
        Checkpoint_MakePattern("output-{n}.txt")
