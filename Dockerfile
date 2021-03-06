FROM golang:1.12
ENV workdir /build
WORKDIR $workdir
COPY . .

RUN apt-get update
RUN apt-get install -y nodejs
RUN curl https://www.npmjs.com/install.sh | sh
RUN npm install -g yarn
WORKDIR /build/app
RUN yarn
RUN yarn build
WORKDIR $workdir
RUN go generate ./...
RUN go install -v .

VOLUME ["/data"]
WORKDIR /data
CMD ["wikifeedia"]

