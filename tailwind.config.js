
const colors = require('tailwindcss/colors');
const plugin = require('tailwindcss/plugin');

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
      animation: {
        "fade-in": "fadeIn 0.2s ease-in-out"
      },
      keyframes: () => ({
        fadeIn: {
          "0%": { opacity: 0 },
          "100%": { opacity: 1 }
        }
      }),
      colors: {
        'shadow-gray': 'rgba(3,3,3,.7)'
      },
      spacing: {
        '3.75':'0.9375rem' ,
        '4.5': '1.125rem',
        '5.5': '1.375rem',
        '6': '1.5rem',
        '7': '1.75rem',
        '9': '2.25rem',
        '9.5': '2.375rem',
        '13': '3.25rem',
        '15': '3.75rem',
        '18': '4.5rem',
        '22': '5.5rem',
        '26': '6.5rem',
        '30': '7.5rem',
        '48': '12rem',
        '88': '22rem',
        '108': '27rem',
        '120': '30rem',
        '160': '40rem',
      },
      boxShadow: {
        'md': '1px 1px 1px 1px rgba(0, 0, 0, 0.1),-1px -1px 1px 1px rgba(0, 0, 0, 0.1)'
      },
      transitionDuration: {
        '600': '600ms',
      },
      backgroundImage: {
        'spiner-1': "url('/images/Spinner-1s-128px.gif')",
        'spiner-2': "url('/images/Spinner-1s-580px.gif')",
      }, 
    },
  },
  plugins: [
    // 指定行数で文章を切り捨てて省略記法
    // require('@tailwindcss/line-clamp'),
    // モバイル端末でのタップ時の影を非表示にする
    plugin(function ({ addUtilities }) {
      addUtilities({
        '.no-tap-highlighting': {
          '-webkit-tap-highlight-color': 'rgba(0,0,0,0)',
        }
      })
    })
  ],
}