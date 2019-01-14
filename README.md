# trimmomatic-docker
Docker image for trimmomatic

The image contains a full install of [trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic), including all necessary dependencies. I am not part of the trimmomatic team - I just made this image.

In detail, the image is set up with:
 - Ubuntu 16.04
 - openjdk version "1.8.0_191"
 - trimmomatic 0.38

To run [trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) you can do the following (this will mount the directory `/home/working` of the container to the current working directory on your local machine):
```bash
$ docker run -it --rm -v $(pwd):/home/working -w /home/working chrishah/trimmomatic:0.38 trimmomatic
```

If you want to use the ILLUMINACLIP option of Trimmomatic, the adapterfiles that ship with Trimmomatic are also in the container, in the location: `/usr/src/Trimmomatic/0.38/Trimmomatic-0.38/adapters/`. So if you want to use one of those, say `TruSeq3-PE-2.fa`, you can make a variable with the full path to this file in the container (see below).
Note that via the docker container you can only access files that are in, or below, your mountpoint (the directory you specify with `-v`). An example for an actual trimmomatic usage with adapter trimming is here:
```bash
prefix=sample
forw=./rawreads/reads.1.fastq.gz
reve=./rawreads/reads.2.fastq.gz
threads=6
adapterfile=/usr/src/Trimmomatic/0.38/Trimmomatic-0.38/adapters/TruSeq3-PE-2.fa

docker run -it --rm -v $(pwd):/home/working -w /home/working chrishah/trimmomatic:0.38 trimmomatic PE \
-threads $threads -phred33 $forw $reve \
$prefix\_forward.paired.fastq.gz $prefix\_forward.singletons.fastq.gz \
$prefix\_reverse.paired.fastq.gz $prefix\_reverse.singletons.fastq.gz \
ILLUMINACLIP:$adapterfile:2:30:10 TRAILING:30 LEADING:30 SLIDINGWINDOW:5:20 MINLEN:100 &> $prefix.trim.log
```
