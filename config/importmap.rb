# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "vue", to: "https://unpkg.com/vue@2.6.11/dist/vue.esm.browser.min.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
