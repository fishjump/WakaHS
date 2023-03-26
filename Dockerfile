# First stage: build the application
FROM haskell:9.2.5-slim AS build

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Install GHC and Cabal dependencies
RUN apt-get update && apt-get install -y libcurl4-gnutls-dev
RUN cabal update

# Build the application
RUN cabal build --enable-tests

# Second stage: create a clean image
FROM ubuntu:20.04

# Set build-time variables
ARG PROJECT_NAME=WakaHS
ARG EXECUTABLE_NAME=wakahs
ARG VERSION=0.1.0.0

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libgmp-dev \
    libcurl4-gnutls-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the compiled binary from the first stage
COPY --from=build /app/dist-newstyle/build/x86_64-linux/ghc-9.2.5/${PROJECT_NAME}-${VERSION}/x/${EXECUTABLE_NAME}/build/${EXECUTABLE_NAME}/${EXECUTABLE_NAME} /app/${EXECUTABLE_NAME}

# Set the working directory
WORKDIR /app

# Set the entrypoint
ENTRYPOINT ["/app/wakahs"]
