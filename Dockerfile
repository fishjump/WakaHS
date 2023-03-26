# First stage: build the application
FROM haskell:9.2.5-slim AS build

# Set working directory
WORKDIR /app

# Add just the .cabal file to capture dependencies
COPY ./WakaHS.cabal .

# Install GHC and Cabal dependencies
RUN apt-get update && apt-get install -y libcurl4-gnutls-dev
RUN cabal update
RUN cabal build --only-dependencies -j4

# Copy the source code
COPY . .

# Build the application
RUN cabal build --enable-tests
RUN cabal install

# Why I got withFile: invalid argument (invalid character) on debian:buster-slim and ubuntu20.04?
# Second stage: create a clean image
FROM haskell:9.2.5-slim

# Install necessary dependencies
RUN apt-get update && apt-get install -y libcurl4-gnutls-dev

# Copy the compiled binary from the first stage
COPY --from=build /root/.cabal/bin/wakahs /app/wakahs

# Set the working directory
WORKDIR /app

# Set the entrypoint
ENTRYPOINT ["/app/wakahs"]
