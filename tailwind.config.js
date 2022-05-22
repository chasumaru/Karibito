
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
    screens: {
      'sm': '520px',
      // => @media (min-width: 520px) { ... }

      'md': '768px',
      // => @media (min-width: 768px) { ... }

      'lg': '960px',
      // => @media (min-width: 960px) { ... }

      'xl': '1280px',
      // => @media (min-width: 1280px) { ... }
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