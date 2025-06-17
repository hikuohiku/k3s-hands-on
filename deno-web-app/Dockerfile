FROM denoland/deno:alpine-2.3.6
WORKDIR /app
USER deno
COPY . .
EXPOSE 8000
CMD ["run", "--allow-net", "main.ts"]
