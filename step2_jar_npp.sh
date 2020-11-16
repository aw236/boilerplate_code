#!/bin/bash
# this installs packages for Python 3 kernel.
# python3 kernels aren't allowed to access the internet so we need to use these commands to install Python packages on the emr notebook.
# pyspark kernels use the pypi repo to install packages. the pyspark and python3 install packages from different locations. python3 only installs from the local node.
# sudo /emr/notebook-env/bin/pip install pixiedust # this step doesn't work in emr-5.30.1. only works in 5.30.0
# sudo /emr/notebook-env/bin/pip install pyod
# add as jar location: s3://us-east-1.elasticmapreduce/libs/script-runner/script-runner.jar
sudo aws s3 cp s3://us-east-1.elasticmapreduce/libs/script-runner/script-runner.jar /home/hadoop/
sudo aws s3 cp s3://oneid-datascience-us-east-1/anyoung/jars/isolation-forest_2.3.0_2.11-1.0.1.jar /usr/lib/spark/jars/
sudo aws s3 cp s3://oneid-datascience-us-east-1/anyoung/jars/xgboost4j-spark_2.12-1.2.0-SNAPSHOT.jar /usr/lib/spark/jars/
sudo aws s3 cp s3://oneid-datascience-us-east-1/anyoung/jars/h2o.jar /usr/lib/spark/jars/