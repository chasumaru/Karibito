// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// サンプル
import Vue from 'vue'
var vm = new Vue({
  el: '#example',
  data: {
    domain: 'HAZM.JP'
  }
})
// Hotwireを適切に設定しないと、エラーメッセージが表示されなくなる
import "@hotwired/turbo-rails"