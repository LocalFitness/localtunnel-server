FROM node:10.1.0-alpine

WORKDIR /app

COPY package.json /app/
COPY yarn.lock /app/

RUN yarn install --production && yarn cache clean

COPY . /app

ENV NODE_ENV production

# Expose both the web manager port and the default localtunnel data allocation ports
EXPOSE 10000
EXPOSE 30000-35000

ENTRYPOINT ["node", "-r", "esm", "./bin/server"]
CMD ["--port", "10000", "--domain", "tunnel.codeshop.dk", "--min_port", "30000", "--max_port", "35000"]
