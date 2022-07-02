### Syncing Portal Documents With Kong
---

## Descriptions
This repository contains an example of using Docker Containers to facilitate running the [Kong Portal CLI Tool](https://github.com/Kong/kong-portal-cli) to deploy a Kong Developer Portal with OpenAPI Specifications. This repo contains multiple ways to host, gather and deploy the OAS files, each Dockerfile correlates to a Github Action which will be simmiarially named.

Please read the documentation in the [Kong Portal CLI Tool](https://github.com/Kong/kong-portal-cli) to understand appropiate environment variables and the importance of the cli.conf.yaml file.

## Dockerfile
Each Dockerfile in this repo contains many simmilararities like:
``` Dockerfile
FROM node:12-alpine
RUN npm install -g kong-portal-cli && apk --no-cache add curl bash
COPY . /workspaces
ENTRYPOINT ["portal"]
CMD ["deploy","default"]
```
Breakdown:
* `FROM` the base image is NODE.JS latest version, we use this base image for npm resources and uses Alpine for a smaller footprint.
* `RUN` installes the oficial Kong Portal CLI Node package.
* `COPY` imports the files from the repo into the Container.
* `ENTRYPOINT` is our initial command being executed. In this case, we're wanting to run the portal command.
* `CMD` the portal action deploy which sends the files to the server and the name of the workspace which default is used as an examples.