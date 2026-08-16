import { defineConfig } from "vite";
import { octane } from "octane/compiler/vite";
import tailwindcss from "@tailwindcss/postcss";

export default defineConfig({
  plugins: [octane()],
  build: { target: "esnext" },
  css: {
    postcss: {
      plugins: [tailwindcss],
    },
  },
});
