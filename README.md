# desenrolai-mcp-ts-template

Template for MCP servers (TypeScript, stdio transport).

## Stack

- Node 22 + TypeScript (ESM, `module: Node16`)
- `@modelcontextprotocol/sdk` — stdio transport
- `zod` — tool input validation
- `vitest` — tests

## Structure

```
src/
  index.ts      # entrypoint — connects transport
  server.ts     # MCP server + tool registrations
  server.test.ts
```

## Getting started

```bash
npm ci
npm run dev          # run via tsx (no build needed)
npm run build        # compile to dist/
npm start            # run compiled output
npm test             # vitest
```

## Transport

This server uses **stdio transport only**. It does not expose HTTP. Configure your MCP client to run:

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["dist/index.js"]
    }
  }
}
```

## Adding tools

Register new tools in `src/server.ts` via `server.tool(name, description, schema, handler)`.
