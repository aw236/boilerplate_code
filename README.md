Boilerplate Code
===========

This folder contains:

==== Docker Set-up =====
    Summary: I wanted a solution that:
        a) Minimized the probability of me hearing/others having to report "it doesn't work on my machine"
        b) Reproducibility of my work across my machines (new laptops, etc.)
        c) Not having to install different sets of packages with distinct package versions that are all compatible with each other
        d) *Never* being forced to install any packages to run anything.
    My solution was this gigantic Docker image with more packages than most any single project will need. Once you are done codesmithing, then I have code that will list all imported Python modules / R libraries, so then I can just build a new `requirements.txt` that contains the ones I ended up needing, which I wouldn't know a priori. Then, I end up with a lightweight Docker image that installs only what is needed to reproduce my work.
    
    Here are the key files:
    
    1. A `Dockerfile` that pulls the 'datascience-notebook:python-3.10' Docker image from the [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html). R, Python and Julia are all available on this image.
    2. A `README.txt` for the specific command to run the Docker image such that you can add/view/edit files in the same directory as the project's `Dockerfile`, on the local machine,.
    3. A `requirements.txt` to install 

==== R =====

    1. a template for every new R project
    2. convenient R functions for data visualization and analysis

== Python ==

    1. a template for every new Python data science project
   
== HiveQL ==

    1. convenient bash shell scripts for exporting Hive query results to csv

=== AWS ===

    1. Instructions to move data from a server to an Amazon Web Service (AWS) S3 bucket.
    2. Instructions on how to work with AWS Athena.
