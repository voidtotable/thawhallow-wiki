FROM peaceiris/mdbook:latest-rust

COPY . .

RUN mdbook build