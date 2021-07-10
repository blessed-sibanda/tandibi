module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      spacing: {
        '14': '3.5rem', // 56px
        '72': '18rem', // 288px
        '84': '21rem', // 336px
        '96': '24rem', // 384px
        '168': '42rem', // 672px
        '192': '48rem', // 768px
      },
      colors: {
        main: {
          default: '#60b0e2',
          '200': '#6020e2',
          '500': '#6cc1ff',
          '800': '#04609a',
        },
        dark: {
          '400': '#8a8a8a',
          '600': '#343538',
          '700': '#2a2b2d',
          '800': '#18191a',
        },
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
