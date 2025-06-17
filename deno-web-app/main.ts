const handler = (_req: Request): Response => {
  return new Response("Hello, Deno!", {
    headers: { "content-type": "text/plain" },
  });
};

console.log("Server running on http://localhost:8000/");
await Deno.serve({ port: 8000 }, handler);
