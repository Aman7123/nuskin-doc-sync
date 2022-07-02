FROM node:12-alpine

COPY . /workspaces
RUN alias p=portal
RUN npm install -g kong-portal-cli && apk --no-cache add curl bash

ENTRYPOINT ["p"]
CMD ["deploy","default"]