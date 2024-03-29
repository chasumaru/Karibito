# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "vue", to: "https://unpkg.com/vue@2.6.11/dist/vue.esm.browser.min.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "app"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.1.0/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss-stimulus-components", to: "https://ga.jspm.io/npm:tailwindcss-stimulus-components@3.0.4/dist/tailwindcss-stimulus-components.modern.js"
pin "flowbite", to: "https://ga.jspm.io/npm:flowbite@1.5.1/dist/flowbite.js"
pin "stimulus-notification", to: "https://ga.jspm.io/npm:stimulus-notification@2.1.0/dist/stimulus-notification.es.js"
pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.9.5/dist/hotkeys.esm.js"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.50.0/dist/index.js"
pin "stimulus-character-counter", to: "https://ga.jspm.io/npm:stimulus-character-counter@4.1.0/dist/stimulus-character-counter.es.js"
