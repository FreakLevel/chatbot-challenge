FROM node:18
WORKDIR /app
COPY ./frontend/package.json .
COPY ./frontend/yarn.lock .
RUN yarn
COPY ./frontend/ .
## EXPOSE [Port you mentioned in the vite.config file]
RUN yarn build
EXPOSE 8000
CMD ["yarn", "preview"]
