# https://hub.docker.com/layers/jupyter/datascience-notebook/python-3.10/images/sha256-887e88f6e6ceb39ec34f5030527268f4f5bb7062efa176281652872038266621?context=explore
FROM jupyter/datascience-notebook:python-3.10

COPY requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

# Copy the contents of the current directory to the working directory
COPY . /app

# Set the working directory
WORKDIR /app

# Expose the Jupyter Lab port; AKA map the port used by Jupyter Lab to port 10000 on the host machine
EXPOSE 8888

# Set the default command to start Jupyter Lab
# CMD ["python", "main.py"]
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
# CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"] # fails
# CMD ["sh", "-c", "jupyter notebook --port=8889 --no-browser --ip=*"]
CMD ["sh", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
