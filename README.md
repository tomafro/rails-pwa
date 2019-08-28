# Rails::PWA
A simple hack to serve service worker scripts from rails apps.

**TLDR**: Serves the webpack defined at `app/javascript/packs/worker.js` from `/worker.js`

Service workers can only intercept requests in the directory and subdirectory they are served from. Rails serves webpacked javascript from paths similar to `/packs/js/application-abcd1234.js`. Any service worker served from a path like this would only be able to operate on paths under `/packs/js/`; generally not what you want.

This gem lets you create a javascript pack for a service worker, and serve it from `/worker.js`.

## Usage
Install the gem (see full instructions below).

Restart your server (so the gem's middleware can be added to the app).

Add a service worker pack by creating a file `app/javascript/packs/worker.js`. Here's a simple example to get started:

```js
for (const name of ["install", "activate", "fetch"]) {
  self.addEventListener(name, event => console.log(event))
}
```

You also need to register your worker, adding something like this to `app/javascript/packs/application.js`:

```js
if ("serviceWorker" in navigator) {
  window.addEventListener("load", function () {
    navigator.serviceWorker.register("/worker.js")
  })
}
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails-pwa'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails-pwa
```

## How it works

This gem installs a very simple piece of `Rack::Middleware` into your app, which intercepts all requests to `/worker.js` and either:

* In development: Rewrites and forwards the request to the rails app (where the usual webpacker magic will occure)
* In other environments: Serves the precompiled `worker.js` pack directly from `/public/packs/js/`. N.B. You may want to use some other form of url rewriting in production, depending on how your app is deployed.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
