FROM node:12-alpine

RUN npm install -g kong-portal-cli && apk --no-cache add curl bash
COPY . /workspaces

ENTRYPOINT ["portal"]
CMD ["deploy","default"]