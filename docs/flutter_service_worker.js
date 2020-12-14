'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "4ac70df8779e64e0c7e67eb0f89debc2",
"assets/assets/background.jpg": "1b5691f359c393720bf37d7aa650b95d",
"assets/assets/player_icons/baby_daisy.png": "83549c08acd136edfcc7ef614168792e",
"assets/assets/player_icons/baby_luigi.png": "afd92b55a546ca3e18e27b34852cd3f4",
"assets/assets/player_icons/baby_mario.png": "3246fc42ab90f6ecd339d81d6513cec8",
"assets/assets/player_icons/baby_peach.png": "35a92ee6b2a2e9006039381c233b55a5",
"assets/assets/player_icons/baby_rosalina.png": "39c6db3f4da72f8764305a120d4b1f75",
"assets/assets/player_icons/bowser.png": "b7d5d380be5e2fbc8c96cfc215901565",
"assets/assets/player_icons/bowser_jr.png": "c6526d439a6059dbc76ce1f5f8ea1976",
"assets/assets/player_icons/cat_peach.png": "9d08c815a742fa93698778badccf25db",
"assets/assets/player_icons/daisy.png": "71d65cd4956b0fa8142fded9b325a99e",
"assets/assets/player_icons/donkey_kong.png": "9e37a0cecd1b0fd5f27baa01f63c1b14",
"assets/assets/player_icons/dry_bones.png": "e2379858c595402a3e96ef6cd0f2490e",
"assets/assets/player_icons/dry_bowser.png": "70af6fe3eebe2ed3eb3ed54e0e7797f1",
"assets/assets/player_icons/gold_mario.png": "37519ff8d624902a23a5888a4d603be3",
"assets/assets/player_icons/iggy.png": "94faaeaaa78ace41cbcdd521f3b5be3f",
"assets/assets/player_icons/inkling_blue.png": "57f70d52165af14de03b5713b9e20bba",
"assets/assets/player_icons/inkling_cyan.png": "27cad89a2dc8e538c4415a627eaba86c",
"assets/assets/player_icons/inkling_green.png": "6a95bd5218109ccc54779b7b3b231c3c",
"assets/assets/player_icons/inkling_orange.png": "95293d07d9c819f9ec5390910248f827",
"assets/assets/player_icons/inkling_pink.png": "67625ec9fcd116041f61a284d897d301",
"assets/assets/player_icons/inkling_purple.png": "902f4347eee246ee8458eaf1959f8782",
"assets/assets/player_icons/isabelle.png": "c6c1edc89b6634294df20c32b8947850",
"assets/assets/player_icons/king_boo.png": "f82191a97333a0390760a97037eb2a12",
"assets/assets/player_icons/koopa.png": "23492c1d8f2bde9f20800921b0ea6331",
"assets/assets/player_icons/lakitu.png": "902562ec23c43d0895eaae5b46559df5",
"assets/assets/player_icons/larry.png": "650a3ec170900f7ef7c9c53e8758ff56",
"assets/assets/player_icons/lemmy.png": "e276dd996b16be1cda824e179e340913",
"assets/assets/player_icons/link.png": "b80c061c8b17e9b176d7aef185e98017",
"assets/assets/player_icons/link_botw.png": "b957d3dc10115c4104d3fd78339ded4b",
"assets/assets/player_icons/ludwig.png": "c2bd355670cfd86e6522945298b799b1",
"assets/assets/player_icons/luigi.png": "f4c87be0b97c4bf10a8581ec3d5c1e12",
"assets/assets/player_icons/mario.png": "4b9e29dc5a80a9f1dbf1364ae18fffad",
"assets/assets/player_icons/metal_mario.png": "6e33345c64ea857c395285cd0bee06a7",
"assets/assets/player_icons/mii.png": "8b35aff04994d02d2692f0321b8837f0",
"assets/assets/player_icons/mii_amiibo.png": "5f5b30976ac0dca0d179f01beb62803b",
"assets/assets/player_icons/morton.png": "daf2d350694208c4471589036f1df61e",
"assets/assets/player_icons/peach.png": "a1924913af80b43451d5a4a888b31766",
"assets/assets/player_icons/pink_gold_peach.png": "6640f4ce5c57b767a0256cb82b352edc",
"assets/assets/player_icons/rosalina.png": "d64f2125634f5c8ae300697b1d2d82c1",
"assets/assets/player_icons/roy.png": "fcd6478118052d1ced9c1ae6d2adaa4c",
"assets/assets/player_icons/secret.png": "860c4b4b34b6ed4bb578f7e22756e461",
"assets/assets/player_icons/shy_guy.png": "1a8cd3ebe5c0382263d45958ab223354",
"assets/assets/player_icons/shy_guy_black.png": "e0600de995a2f497a0b75babad25d8c7",
"assets/assets/player_icons/shy_guy_blue.png": "c8f1adc662cb51fd71109e62fcd6daf7",
"assets/assets/player_icons/shy_guy_green.png": "fa9fbfa4a11d3720ebd9ad4a5d94c941",
"assets/assets/player_icons/shy_guy_light_blue.png": "569125138d2547a1eb520d36534b626e",
"assets/assets/player_icons/shy_guy_orange.png": "aa1e3731012bdee58e7f55f16109852d",
"assets/assets/player_icons/shy_guy_pink.png": "e956ffe037efd473cd28ba1f3d6a2ff2",
"assets/assets/player_icons/shy_guy_white.png": "5d7e4d276d69f5664bd476f2a0d9cc4e",
"assets/assets/player_icons/shy_guy_yellow.png": "4341e15661fa4ffed7229b6d93025f49",
"assets/assets/player_icons/tanooki_mario.png": "d35ad06169f78e043c396173931565ac",
"assets/assets/player_icons/toad.png": "813b8ec23cbffe4eb300eec21cd01ef9",
"assets/assets/player_icons/toadette.png": "aec0544adced50b4b12740d1ef5d35c4",
"assets/assets/player_icons/villager.png": "2632b9f2bc6b7807a2afa5d4ad46e573",
"assets/assets/player_icons/villager_female.png": "a3484221ba12c18e72d257014346c139",
"assets/assets/player_icons/villager_male.png": "ab7f951f5143c2164b4ca157b9bcaf51",
"assets/assets/player_icons/waluigi.png": "9c43863dce93360691a36656206e98c5",
"assets/assets/player_icons/wario.png": "b124a8e66cfb095cd5384979b0efff5f",
"assets/assets/player_icons/wendy.png": "0e1ac8538ff5400571c532c026f28274",
"assets/assets/player_icons/yoshi.png": "a06d9859b9e4bb73a58b7fe8cf98a6b4",
"assets/assets/player_icons/yoshi_black.png": "84b74d416148f0f79ea98a6f3a650919",
"assets/assets/player_icons/yoshi_blue.png": "e3ad7f651ecb5c5ddd1f0109d5a8f70a",
"assets/assets/player_icons/yoshi_light_blue.png": "4c7166c5aeb0655be23bcb275b2d1991",
"assets/assets/player_icons/yoshi_orange.png": "020197807c3f010b69ea5147d2a94a21",
"assets/assets/player_icons/yoshi_pink.png": "b6a4013d4d4637e03c29d67b61ca4400",
"assets/assets/player_icons/yoshi_red.png": "979091007b538cfadaf09b63c01e886f",
"assets/assets/player_icons/yoshi_white.png": "c8e1b4da19993cb87050d88f05081de2",
"assets/assets/player_icons/yoshi_yellow.png": "4ef56ec78aca279b5802eb740c353fac",
"assets/assets/positions/position1.png": "d4efab1d51011b3f032d1ed2b7a12a95",
"assets/assets/positions/position10.png": "96b1103584c8556c458c5ddd41b002c2",
"assets/assets/positions/position11.png": "32a34849ef8870e7f572f5420745fc1b",
"assets/assets/positions/position12.png": "bc4c6490e430531cc58e97dc9275ae2e",
"assets/assets/positions/position2.png": "7afe75fe182797d77b4f217fcbd36c3b",
"assets/assets/positions/position3.png": "199cb85cd1e7f75a91ffc75e16ad71c6",
"assets/assets/positions/position4.png": "7eadb99b63aeae234ece9a5a29659aff",
"assets/assets/positions/position5.png": "763481ffd5f4745e38e8cb62d8d3e7a1",
"assets/assets/positions/position6.png": "9077c37bdb175faa4bba28d900edc110",
"assets/assets/positions/position7.png": "6cc1fe65372dbe91f6c863255d453eb6",
"assets/assets/positions/position8.png": "a8aa06f1f6eaaa92edc65058c483e5ad",
"assets/assets/positions/position9.png": "b567cd843f8ac228a1b85020f827163c",
"assets/assets/race_flag.png": "3088a277fa8fad7691f011bc66f908aa",
"assets/assets/welcome_page/icon_flat.png": "aa55341a5d1326f038ab53ed2babbca7",
"assets/assets/welcome_page/icon_material.png": "f331552f316eaac80322db17a2c1cb58",
"assets/assets/welcome_page/placement_points.png": "fb1fddd2f46c02bb137b3a87bc2ea0b2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/lang/de.json": "12b9d36ef057f092bffb19fd4d99ddb6",
"assets/lang/en.json": "d62b424d952aedd690e4481caa1dbe89",
"assets/NOTICES": "1ed7234802ba0e5fa3cd697dfa2aae01",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"favicon.png": "39fd211940681f138becfd5a419b29ad",
"icons/Icon-192.png": "9d525d00057b608b1bd0b0a9c225733e",
"icons/Icon-512.png": "c51cd78c789951b35bc51fe888f76df0",
"index.html": "380db187ff6cf4e669470b9cdcc58d89",
"/": "380db187ff6cf4e669470b9cdcc58d89",
"main.dart.js": "013e86f12a8a1b130803eb75d8d7a38b",
"manifest.json": "376589671dcddc1c2f6cb27e4848b3b5",
"version.json": "80ce59778abb4d59027df4009e969ff2"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
