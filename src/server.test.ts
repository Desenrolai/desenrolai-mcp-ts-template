import { describe, it, expect } from 'vitest';
import { createServer } from './server.js';

describe('createServer', () => {
  it('returns an MCP server instance', () => {
    const server = createServer();
    expect(server).toBeDefined();
  });
});
