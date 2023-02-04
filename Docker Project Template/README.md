This Dockerfile specifies that the base image should be the Python 3.8 image, installs some system dependencies and Python libraries that are commonly used in data science, and copies the files in the current directory into the /app directory in the container. The command to run when the container is started is specified at the end with CMD ["python", "main.py"].

To build the Docker image, navigate to the directory where the Dockerfile is located and run the following command:

`docker build -t data-science-image .`

This will build an image with the name `data-science-image`

----------------------------------------------------
To run the image, use the following command:

```
docker run -it -p 10000:8888 \
  -e GRANT_SUDO=yes \
  -e JUPYTER_TOKEN=letmein \
  --user root \
  -v "/Users/aloha2018/My Drive (andcy7@gmail.com)/coding projects/website_scraper":/app \
  data-science-image
```

This will start a new container from the image and run the command specified in the CMD instruction in the Dockerfile. The -it flag runs the container in interactive mode, allowing you to enter commands and see the output.

The `-v` (or `--volume`) argument to docker run is for creating storage space inside a container that is separate from the rest of the container filesystem. There are two forms of the command.

When given a single argument, like `-v /var/lib/mysql`, this allocates space from Docker and mounts it at the given location. This is primarily a way of allocating storage from Docker that is distinct from your service container. For example, you may want to run a newer version of a database application, which involves tearing down your existing MySQL container and starting a new one. You want your data to survive this process, so you store it in a volume that can be accessed by your database container.

Docker containers have an isolated file system. This means that the program running in the container (jupyter notebook in your case) sees different folders than the ones you have in the host system.

If you want to give the container access to one folder in the host, you can use the option `-v` when running the docker. 
Example: 

```
nvidia-docker run -it -p 8888:8888 -v /PATH_TO_HOST_FOLDER:/PATH_TO_CONTAINER_FOLDER --entrypoint /usr/local/bin/jupyter NAMEOFDOCKERIMAGE notebook --allow-root --ip=0.0.0.0 --no-browser
```

- PATH_TO_HOST_FOLDER is the path of the folder in the host system that you want to share with the container.
- PATH_TO_CONTAINER_FOLDER is the mountpoint of the folder in the container file system (e.g., /home/username/work where username is the name of the user in the container).
- The path in the container depends on the docker image that you are using. If you do not know the path in the container, you can take a look at the container file system, by running a bash inside the container with this command:
- `docker run -it --entrypoint /bin/bash data-science-image`
- output: /app



----------------------------------------------------
Go to the Docker Desktop app. Click "Open with Browser" icon next to the currently running Docker container. Alternatively, visit: http://localhost:10000/ and use the Jupyter Token specified in the `docker run` command (letmein).

Reference: https://github.com/jupyter/docker-stacks/issues/1187
