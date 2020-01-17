import Vue from 'vue'
import App from './App.vue'
import router from './router/index.js'
import store from './store'
import vuetify from './plugins/vuetify'
import DateFilter from './filters/date'
import MoneyFilter from './filters/money'

Vue.filter('date', DateFilter)
Vue.filter('money', MoneyFilter)


let user = null;
try {
  user = JSON.parse(localStorage.getItem('user'));
} catch (e) {
  user = null;
}
if (typeof user !== 'undefined' && user != null) {
  //console.log('wczytałem usera')
  store.dispatch('setLocalUser',user)
}

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App),
}).$mount('#app')
