# AGENTS.md

## Build, Lint, and Test Commands
- **JavaScript/React (zebar/starter):**
  - No standard npm/yarn scripts. For custom builds, refer to zpack.json and GlazeWM/Zebar docs.
  - To run the widget, open with-glazewm.html in a browser or GlazeWM environment.
- **Linting/Formatting:**
  - JS/TS: Use Prettier (`.prettierrc.json`) with 4 spaces per tab, max line length 160.
  - Lua: Format manually; auto-require is disabled (`.luarc.json`).
- **Testing:**
  - No standard test runner detected. For JS, add tests using your preferred framework (Jest, Vitest, etc.).
  - For Lua, use Busted or similar if needed.

## Code Style Guidelines
- **Imports:**
  - JS: Use ES modules, import from URLs when needed.
  - Lua: Use explicit `require` statements; avoid auto-require.
- **Formatting:**
  - JS/TS: 4 spaces per tab, max line length 160.
  - Lua: Follow existing file indentation and spacing.
- **Types:**
  - JS: Prefer explicit types if using TypeScript. Otherwise, use clear variable names and structures.
- **Naming Conventions:**
  - Use camelCase for variables/functions, PascalCase for components/classes.
- **Error Handling:**
  - JS: Use conditional rendering and checks for undefined/null values.
  - Lua: Use pcall or error for exception handling.
- **General:**
  - Keep code modular and readable.
  - Document complex logic with comments.
  - Avoid unused variables and imports.

_No Cursor or Copilot rules detected._
