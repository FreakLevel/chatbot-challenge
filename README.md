# Chatbot Challenge

## Problem

This project was focused on creating a chatbot that should respond to 3 different options:

- Request information about a deposit
- Make a requirement to buy voucher paper
- Request economic indicators

## Solution

This project has two services, a frontend, and a backend.

### Backend

| Tech | Version |
|------|---------|
| Ruby | 3.2.1 |
| RoR | 7.0.4 |
| Anycable | 1.1 |

Was built on ruby on rails, the project was built as an api but there is no use at this moment.

The communication with the frontend runs through a websocket powered by anycable (an alternative to action cable), making the communication in a bidirectional way and in real-time.

The solution was thought of as an enterprise that sells products of the company and after a period receives the money of their business. In this case, there are no specific periods.
In this case was in consideration the possibility of buying things with the same product, making movements of expenses (also the deposit to the personal bank account of the client), and having the possibility of having transactions with different currencies.

The "bot" only are paths of a conversation, a minimum approx of a tree of options, a solution elegant but would take a lot of time. Each option of conversation is connected with another to continue the conversation until the end, where the channel restarts the conversation to the main menu.

The rails service has a seed to test the application but doesn't have a way to interact and add other information through an api or another alternative (except rails console, gross). But allow the flexibility to modify some data for different scenarios and test new routes to add to the bot.

The principal focus was on the construction of a bot that could evolve and be bigger, with more options.

Also, have a service to connect to an API to request information about the economic indicators required.

### Frontend

| Tech | Version |
|----------|-----------|
| Node | 18.15.0 |
| Vite | 4.2 |
|Typescript| 4.9.3 |
| React | 18.2.0 |
| Jotai | 2.0.3 |
| React MD | 8.0.6 |

The frontend is very minimalist, having a chat that uses all the screen and work as a bubble chat.

The project was created with Vite and used Typescript with SWC. To render the messages from the server they use React Markdown, a library that, as the name says, renders strings of markdown content as safety HTML.

To manage the communication have the javascript library of anycable, used to receive the messages front the server and to send responses.

The state manager used was jotai, there were a lot of problems with react context that take so much time and I wasn't able to solve it in time, the use of redux was discarded because the complexity/usage was not rented, so I preferred a library I had acknowledged of their existence but never used, Jotai, a very minimalistic capacity to control different states.

## Development

To work run in development you should run postgres, redis, and install anycable binary to run it locally or dockerized.

Inside the folder of config, in the backend project, is a file (`application.yml.example`) with the env variables you should modify.

In each project, you have to install the dependencies, frontend with yarn (npm | pnpm), and use bundle in the backend.

To run the frontend, you should run the `dev` script on the package.json's file. `yarn dev`

To run the backend first you have to create the database, run the migrations and run the seed.
`rails db:setup`
After the database is ready, you can run with `foreman` or `overmind` or another process manager, the Procfile inside of the backend folder.
`overmind s Procfile.dev`

## Production

The project has a docker compose's file to run it as production and without the need to install any dependency.

Just `docker-compose build` and `docker-compose up`, wait until all is ready and you can go to the frontend port to see the project running.

## Improvements

The project has a lot of improvements to realize, but some of what I wanted to add but for the time wasn't possible.

- Add Unit Test.
- Add Integration Test.
- Add an API to create/delete/modify information in the database.
- Add a validation system for the bot paths.
- Add the posibility to send links with files/images through the messages in markdown.

