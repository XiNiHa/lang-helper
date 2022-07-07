import { defineConfig } from "vite";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  plugins: [
    VitePWA({
      strategies: 'injectManifest',
      srcDir: 'src',
      filename: 'sw.js',
      registerType: "autoUpdate",
      manifest: {
        name: 'Language Helper',
        short_name: 'LangHelper', 
        description: 'Language Helper',
        theme_color: '#0079d9',
        background_color: '#11578f',
        icons: [
          {
            src: "/android-chrome-192x192.png",
            sizes: "192x192",
            type: "image/png"
          },
          {
            src: "/android-chrome-512x512.png",
            sizes: "512x512",
            type: "image/png"
          }
        ],
      },
      workbox: {
        globPatterns: [
          '**/*{js,css,html,ico,png,jpg,jpeg,svg,mp3,wav}',
        ]
      },
      devOptions: { enabled: true },
    }),
  ],
});
