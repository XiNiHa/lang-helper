import { clientsClaim } from "workbox-core";
import { ExpirationPlugin } from "workbox-expiration";
import { cleanupOutdatedCaches, precacheAndRoute } from "workbox-precaching";
import { registerRoute, Route } from "workbox-routing";
import { StaleWhileRevalidate } from "workbox-strategies";
import { CacheFirst } from "workbox-strategies";
import { CacheableResponsePlugin } from 'workbox-cacheable-response'

/// <reference no-default-lib="true"/>
/// <reference lib="es2015" />
/// <reference lib="webworker" />

cleanupOutdatedCaches();
precacheAndRoute(self.__WB_MANIFEST);

self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "SKIP_WAITING") self.skipWaiting();
});

registerRoute(
  new Route(
    ({ url }) => url.pathname === "/assets",
    new CacheFirst({
      cacheName: "assets",
      plugins: [
        new CacheableResponsePlugin({ statuses: [0, 200] }),
        new ExpirationPlugin({ maxAgeSeconds: 60 * 60 * 24 * 10 }),
      ],
    })
  )
);

registerRoute(
  new Route(
    ({ url }) => url.pathname === "/words",
    new StaleWhileRevalidate({ cacheName: "data" })
  )
);

self.skipWaiting();
clientsClaim();
