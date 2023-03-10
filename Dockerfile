FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16

ARG TARGETPLATFORM

ARG BUILDPLATFORM

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > /log 

# Commando to run multyplatforms 
# madzilla@madzilla:~/Documentos/code/docker-fh/cron-ticker$ docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t modeselektor333/cron-ticker --push .

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run test

RUN rm -rf test && rm -rf node_modules

RUN npm install --prod

CMD [ "npm", "start" ]