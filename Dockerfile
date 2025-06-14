FROM node:20  AS build
WORKDIR /opt/app
COPY *.js /opt/app
COPY *.json /opt/app
RUN npm install

FROM node:20.18.2-alpine
EXPOSE 8080
ENV DB_HOST="mysql"
RUN addgroup -S expense && adduser -S expense -G expense && \
    mkdir /opt/app && \
    chown -R expense:expense /opt/app
WORKDIR /opt/app
COPY --from=build /opt/app /opt/app  
USER expense
CMD ["node", "index.js"]
