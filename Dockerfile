# Stage 1: Build Next.js frontend
FROM node:19-alpine AS build-frontend
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend .
RUN npm run build

# Stage 2: Build Phoenix backend
FROM elixir:1.17-alpine AS build-backend
RUN apk add --no-cache build-base npm git
WORKDIR /app
COPY backend/mix.exs backend/mix.lock ./
ENV MIX_ENV=prod
RUN mix do local.hex --force, local.rebar --force, deps.get --only prod, deps.compile
COPY backend .
RUN mix compile

# Stage 3: Final image
FROM elixir:1.17-alpine
RUN apk add --no-cache build-base npm git
WORKDIR /app

# Copy Phoenix app
COPY --from=build-backend /app /app

ENV MIX_ENV=prod

# Install Phoenix dependencies
RUN mix do local.hex --force, local.rebar --force, deps.get --only prod, deps.compile

# Copy built Next.js app
COPY --from=build-frontend /app/frontend/out /app/priv/static

# Expose ports for Phoenix and Next.js
EXPOSE 4000

# Start Phoenix server
CMD ["mix", "phx.server"]
