#!/bin/bash
# this script installs to the location that PySpark looks for packages
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install ipykernel
sudo python3 -m pip install pixiedust
sudo python3 -m pip install "pyod==0.8.3"

# https://h2o-release.s3.amazonaws.com/h2o/rel-zeno/3/index.html
# install h2o + dependencies
sudo python3 -m pip install "requests==2.23.0"
sudo python3 -m pip install "colorama>=0.3.8"
sudo python3 -m pip install "future==0.18.2"
sudo python3 -m pip install "h2o==3.30.1.3"
sudo python3 -m pip install "h2o-py==3.30.1.3"
sudo python3 -m pip install "pyarrow==1.0.1"
sudo python3 -m pip install "tabulate==0.8.7"