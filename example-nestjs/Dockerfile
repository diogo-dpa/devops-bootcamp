FROM node:23-alpine3.20 AS build

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

# Install dependencies
RUN yarn

COPY . .

RUN yarn run build

# yarn install --production -> Install production dependencies only. This will remove dev dependencies and only keep the ones needed for production
# yarn cache clean -> Clean the yarn cache to reduce image size
RUN yarn install --production && yarn cache clean

# Multi-stage build
# Use a smaller image for production
FROM node:23-alpine3.20 AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["yarn", "run", "start:prod"]