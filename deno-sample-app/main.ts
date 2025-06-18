const handler = (_req: Request): Response => {
  return new Response("Hello, Deno!", {
    headers: { "content-type": "text/plain" },
  });
};

console.log("Server running");
await Deno.serve({ port: 8000 }, handler);
