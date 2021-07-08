module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
      },
      colors: {
        main: {
          // light: '#85d7ff',
          DEFAULT: '#60b0e2',
          dark: '#41a1dd',
        },
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
