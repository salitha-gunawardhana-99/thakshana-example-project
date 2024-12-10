# Step 1: Use the official Rust image for building
FROM rust:1.73 AS builder

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Cargo.toml and src folder
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# Build the Rust project
RUN cargo build --release

# Step 2: Use a smaller image for runtime
FROM debian:buster-slim

# Copy the compiled binary from the builder stage
COPY --from=builder /usr/src/app/target/release/thakshana-example-project /usr/local/bin/thakshana-example-project

# Set the entry point to the binary
ENTRYPOINT ["thakshana-example-project"]

# Default command if none provided
CMD []