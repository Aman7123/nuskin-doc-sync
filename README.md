### Syncing Portal Documents With Kong
---

### Table of Contents
* [Descriptions](#Descriptions)
* Diagrams
  * [Standard Portal API](#Standard-Portal-API-Usage)
  * [Advanced Bash Scripting](#Fetching-OAS-With-Bash-Script)
* Pipeline
  * [Dockerfile-Standard](#Dockerfile)
  * [Dockerfile-Fetch](#Dockerfile-Fetch)

## Descriptions
This repository contains an example of using Docker Containers to facilitate running the [Kong Portal CLI Tool](https://github.com/Kong/kong-portal-cli) to deploy a Kong Developer Portal with OpenAPI Specifications. This repo contains multiple ways to host, gather and deploy the OAS files, each Dockerfile correlates to a Github Action which will be similarly named.

Please read the documentation in the [Kong Portal CLI Tool](https://github.com/Kong/kong-portal-cli) to understand appropriate environment variables and the importance of the cli.conf.yaml file.

## Standard Portal API Usage
![Standard Portal API Usage](drawio/Standard.png?raw=true)

## Fetching OAS With Bash Script
![Fetching OAS With Bash Script](drawio/Fetch.png?raw=true)

## Dockerfile
Each Dockerfile in this repo contains many similarities like:
``` Dockerfile
FROM node:12-alpine
RUN npm install -g kong-portal-cli && apk --no-cache add curl bash
COPY . /workspaces
ENTRYPOINT ["portal"]
CMD ["deploy","default"]
```
Breakdown:
* `FROM` the base image is NODE.JS latest version, we use this base image for npm resources and uses Alpine for a smaller footprint.
* `RUN` installed the official Kong Portal CLI Node package.
* `COPY` imports the files from the repo into the Container.
* `ENTRYPOINT` is our initial command being executed. In this case, we're wanting to run the portal command.
* `CMD` the portal action deploy which sends the files to the server and the name of the workspace which default is used as an examples.

### Dockerfile-Standard
These build instructions only needs the `COPY` function to transfer the default workspace from the repo into the container.

### Dockerfile-Fetch
This file utilizes the `fetch.sh` file which requires a few parameters that are provided as ENV in the Dockerfile:
``` Dockerfile
ENV WORKSPACE dev
ENV WORKSPACE_DIR /workspaces
ENV FQWN ${WORKSPACE_DIR}/${WORKSPACE}
WORKDIR ${WORKSPACE_DIR}
COPY . .
RUN bash fetch.sh
WORKDIR /
```
Breakdown:
* `ENV` the folders in this repo such as 'default' and 'dev' need to be placed into the directory `/workspaces` in the container.
* `ENV FQWN` is the EXACT location of the workspace which is used to make the spec directory and fill it with OAS.
* `WORKDIR` we need to move the pwd of the container user to the `/workspaces` folder to execute the fetch
* `RUN` in addition to the RUN command that installs the Portal CLI Tool we need to run this Bash script to pull in OAS specs.

## Github Actions
### STANDARD
This action listens for a push to this branch with a comment containing the text `[release]` and then facilitates building the `Dockerfile-Standard` and running it. You can view the output of all commands in this action in the details of the job.

### FETCH
This action listens for dispatch from the run button on the Actions tab in this repo and then facilitates building the `Dockerfile-Fetch` and running it. You can view the output of all commands in this action in the details of the job.