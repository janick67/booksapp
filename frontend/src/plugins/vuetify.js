import Vue from 'vue'
import Vuetify from 'vuetify/lib'
import '@mdi/font/css/materialdesignicons.css'
import pl from 'vuetify/src/locale/pl.ts'

Vue.use(Vuetify)

export default new Vuetify({
  theme: {
    options: {
      customProperties: true
    },
    themes: {
      light: {
        primary: '#3F51B5',
        secondary: '#E3F2FD',
        accent: '#616161',
        background: '#E3F2FD',
        error: '#FF5252',
        info: '#2196F3',
        success: '#4CAF50',
        warning: '#FFC107'
      }
    }
  },
  lang: {
    locales: { pl },
    current: 'pl'
  },
  icons: {
    iconfont: 'mdi'
  }
})
