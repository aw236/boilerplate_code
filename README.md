# Data Science Boilerplate Repository

Welcome to the **Data Science Boilerplate Repository**! This repository provides a comprehensive collection of reusable templates, scripts, and utilities to streamline data science workflows across R, Python, HiveQL, and AWS environments (including EMR). Designed for reproducibility, ease of use, and flexibility, it aims to minimize setup headaches and maximize productivity.

## Purpose

This repository addresses common pain points in data science projects:
- **Cross-machine consistency**: Eliminate "it doesn’t work on my machine" issues.
- **Reproducibility**: Ensure workflows are portable across systems and time.
- **Simplified setup**: Avoid the hassle of managing conflicting package versions or manual installations.
- **Flexibility**: Provide robust starting points for diverse tools and platforms.

## Contents

The repository is organized into the following key sections:

### Docker Setup
**Goal**: A self-contained, reproducible environment with minimal setup friction.
- **Key Features**:
  - Uses the `datascience-notebook:python-3.10` image from [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html), supporting R, Python, and Julia.
  - Mounts local directories for seamless file access and editing.
  - Includes a comprehensive `requirements.txt` with commonly used packages, allowing you to trim dependencies post-development for lightweight deployments.
- **Files**:
  - `Dockerfile`: Base image configuration.
  - `README.txt`: Instructions to run the Docker image and bind local directories.
  - `requirements.txt`: Initial package list for the Docker environment.

### R
- **Templates**: A standardized template for new R projects.
- **Convenience Functions**:
  - `multiplot()`: Plot multiple `ggplot2` objects in custom layouts.
  - `pairs.panels()`: Create pairs plots or correlation matrices.
  - `ggcorplot()`: Generate advanced correlation visualizations.
- **Documentation**: A "Model Cheat Sheet" (R Markdown) covering regression, classification, and model selection.

### Python
- **Templates**: A template for Python data science projects, compatible with Jupyter and common libraries.
- **Environment Setup**: A `python37dev.yml` Conda file for Python 3.7, R, RStudio, and JupyterLab, with instructions for additional package installations (e.g., Plotnine).

### HiveQL
- **Bash Scripts**:
  - `hive_query_csv_export.sh`: Execute Hive queries sequentially or in batches, exporting results to CSV with error handling.
  - `temp.sh`: Interactive script to run HiveQL files, track execution time, and send email notifications.
- **Use Case**: Automate Hive workflows for data extraction and reporting.

### AWS
- **General AWS**:
  - Instructions for transferring data to Amazon S3 and querying with AWS Athena.
- **EMR-Specific Setup**:
  - Shell scripts to configure Python 3 kernels and Spark dependencies on AWS EMR notebooks:
    - Install Python packages (e.g., `pyod`, `h2o`, `shap`) for EMR’s Python 3 kernel (`/emr/notebook-env/bin/pip`).
    - Copy Spark JARs (e.g., Isolation Forest, XGBoost, H2O) from S3 to `/usr/lib/spark/jars/`.
    - Example scripts for specific projects (e.g., TID environment setup).
  - **Files**:
    - `emr-python3-setup.sh`: General Python 3 kernel package installation and JAR setup.
    - `emr-tid-env.sh`: Environment setup for the TID project with specific package versions.
    - `emr-jars-only.sh`: Script to copy JARs without package installation.
    - `emr-minimal-pkgs.sh`: Minimal package installation with flexible versioning.

### Additional Files
- **RStudio Configuration**: `.Rprofile` for consistent R project settings.
- **Boilerplate Summary**: Overview document of the repository’s contents.

## Getting Started

### Prerequisites
- **Docker**: For the Docker setup.
- **R**: R and RStudio for R workflows.
- **Python**: Anaconda for Python environments.
- **Hive**: A Hive-enabled server for HiveQL scripts.
- **AWS**: AWS CLI and access to S3, Athena, and EMR (for AWS features).
- **Git**: To clone the repository.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/your-repo-name.git
   cd your-repo-name
   ```

2. **Docker Setup**:
- Build and run the Docker image (see README.txt for exact commands):
   ```bash
    docker build -t ds-boilerplate .
    docker run -p 8888:8888 -v $(pwd):/home/jovyan/work ds-boilerplate
    ```

3. **Python Environment (Non-Docker)**:
   ```bash
    conda env create -f python37dev.yml
    conda activate python37dev
    pip install git+git://github.com/has2k1/plotnine.git
   ```
   
4. **HiveQL Setup**:
   ```bash
    chmod u+x hive_query_csv_export.sh temp.sh
    ./hive_query_csv_export.sh  # or ./temp.sh
   ```

5. **AWS EMR Setup**:
- On an EMR cluster’s master node:
   ```bash
    chmod u+x emr-python3-setup.sh
    sudo ./emr-python3-setup.sh
   ```
   
### Usage Examples

## Docker: Run a Jupyter Notebook ##
   ```bash
    docker run -p 8888:8888 -v $(pwd):/home/jovyan/work ds-boilerplate
    # Access Jupyter at http://localhost:8888
   ```

## R: Visualize Data ##
   ```r
    source("R/convenience_functions.R")
    library(ggplot2)
    p1 <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
    p2 <- ggplot(mtcars, aes(hp, disp)) + geom_point()
    multiplot(p1, p2, cols = 2)
   ```

## HiveQL: Export Query Results ##
   ```bash
    ./temp.sh
    # Enter your HiveQL file (e.g., script.hql) when prompted
   ```

## EMR: Install Packages and JARs ##
   ```bash
    sudo ./emr-tid-env.sh
    # Verify in a notebook: import h2o, pyod, shap
   ```

## Contributing ##
Contributions are encouraged! To contribute:

1. Fork the repository.
2. Create a branch (git checkout -b feature/your-feature).
3. Commit changes (git commit -m "Add feature").
4. Push (git push origin feature/your-feature).
5. Open a pull request.


## Customization Notes ##
Replace yourusername/your-repo-name with your actual GitHub details.
Ensure a LICENSE file exists (e.g., MIT License).
The Docker section assumes a Dockerfile and requirements.txt exist; adjust if they’re placeholders.
The EMR scripts are named generically (e.g., emr-python3-setup.sh)—rename them to match your actual files if needed.
