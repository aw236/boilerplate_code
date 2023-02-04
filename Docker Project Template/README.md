This Dockerfile specifies that the base image should be based on [datascience-notebook](https://hub.docker.com/layers/jupyter/datascience-notebook/python-3.10/images/sha256-887e88f6e6ceb39ec34f5030527268f4f5bb7062efa176281652872038266621?context=explore). Then, I install some system dependencies and Python libraries that are commonly used in data science, and copies the files in the current directory into the /app directory in the container. The command to run when the container is started is specified at the end with `CMD`.

I wanted a solution that:
    a) Minimized the probability of me hearing/others having to report "it doesn't work on my machine"
    b) Reproducibility of my work across my machines (new laptops, etc.)
    c) Not having to install different sets of packages with distinct package versions that are all compatible with each other
    d) *Never* being forced to install any packages to run anything.
My solution is this gigantic Docker image with more packages than most any single project will need. Once I am done codesmithing/developing my work, then I have use some Python/R code I wrote to list all imported Python modules / R libraries and I save them in a new `requirements.txt`. Hence, this new `requirements.txt` contains only the Python modules/R libraries that I ended up needing for my project, which I wouldn't know a priori. Pro of this approach is that I have already wrestled with different versions of different packages and managed to build a working environment which I can then just re-use for project after project before another major wrestling match in a few years when I want to update one or more modules/libraries/packages. Con of this approach is that it shifts some work to the end, where I need to engage this process of creating a shorter `requirements.txt` at the conclusion of each project. But, that should be much more painless and still much more efficient overall.

In the end, I end up with a lightweight Docker image that installs only what is needed to reproduce my work. So I start off breaking [Docker best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) but end up conforming to them in the end.

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
Go to the Docker Desktop app. Click `Open with Browser` icon next to the currently running Docker container. Alternatively, visit: `http://localhost:10000/` and use the Jupyter Token specified in the `docker run` command: `letmein`.

Reference: https://github.com/jupyter/docker-stacks/issues/1187
