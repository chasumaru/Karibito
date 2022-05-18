
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
    extend: {
    darkMode: 'media',
      colors: {
        'teal': colors.teal,
        hobby: {
          100: '#001871',
          200: '#ff585d',
          300: '#ffb549',
          400: '#41b6e6',
        }
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}