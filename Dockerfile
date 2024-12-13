FROM alpine:latest
WORKDIR /app
COPY main /app
EXPOSE 80
CMD ["./main"]
