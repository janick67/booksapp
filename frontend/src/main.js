import Vue from 'vue'
import App from './App.vue'
import router from './router/index.js'
import store from './store'
import vuetify from './plugins/vuetify'
import DateFilter from './filters/date'
import MoneyFilter from './filters/money'

Vue.filter('date', DateFilter)
Vue.filter('money', MoneyFilter)

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App),
  created () {
    this.$store.dispatch('loadOrders')
    this.$store.dispatch('loadBooks')
  }
}).$mount('#app')
