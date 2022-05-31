
const colors = require('tailwindcss/colors');

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  darkMode:'media ',
  theme: {
    fontFamily: {
      body: [
        '游ゴシック',
        'YuGothic', 
        "ヒラギノ角ゴ Pro",
        "Hiragino Kaku Gothic Pro",
        'メイリオ',
        'Meiryo',
        'sans-serif'
      ]
    },
    extend: {
      colors: {
        'base-white': '#f9fafb',
        'base-gray' : '#f4f4f5',
        // 緑を調製する
        'base-brown' : '#ecd94b',
      },
      boxShadow: {
        'md': '1px 1px 1px 1px rgba(0, 0, 0, 0.1),-1px -1px 1px 1px rgba(0, 0, 0, 0.1)'
      }
      // backgroundImage: {
      //   'main-img-1': "url('/images/#.jpg')",
      //   'main-img-2': "url('/images/main_background_2.jpg')",
      // },
      // spacing: {
      //   'sidebar': '500px'
      // },
      
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}