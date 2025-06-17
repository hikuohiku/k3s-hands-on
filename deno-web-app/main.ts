import { serve } from "https://deno.land/std@0.203.0/http/server.ts";

const handler = (_req: Request): Response => {
  return new Response("Hello, Deno!", {
    headers: { "content-type": "text/plain" },
  });
};

console.log("Server running on http://localhost:8000/");
await serve(handler, { port: 8000 });
