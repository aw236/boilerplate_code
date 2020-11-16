#!/bin/bash
# this script installs to the location that PySpark looks for packages
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install ipykernel
sudo python3 -m pip install pixiedust
sudo python3 -m pip install pyod

# https://h2o-release.s3.amazonaws.com/h2o/rel-zeno/3/index.html
# install h2o + dependencies
sudo python3 -m pip install requests
sudo python3 -m pip install tabulate
sudo python3 -m pip install "colorama>=0.3.8"
sudo python3 -m pip install future
sudo python3 -m pip install h2o
sudo python3 -m pip install h2o-py
sudo python3 -m pip install pyarrow