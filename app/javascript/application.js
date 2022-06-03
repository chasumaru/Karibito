// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// Hotwireを適切に設定しないと、エラーメッセージが表示されなくなる
import "@hotwired/turbo-rails"
// Hotwireを利用したくない場面では適宜無効化する
// Turbo.session.drive = false


import Vue from 'vue'

const app = new Vue({
  el: "#app",
  data: {
    isOpen: false,
  }
});