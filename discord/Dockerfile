FROM node:alpine

RUN apk add --no-cache git

RUN mkdir /app
WORKDIR /app

RUN git clone https://github.com/skylerspaeth/LearSense.git .
RUN npm install

ENTRYPOINT cp $CRED_FILE config.json && node .
