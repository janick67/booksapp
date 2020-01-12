import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/Home.vue'
import Signin from '@/views/Signin.vue'
import Orders from '@/views/Orders/Orders.vue'
import OrderAdd from '@/views/Orders/OrderAdd.vue'
import UserAdd from '@/views/Admin/UserAdd.vue'
import AuthGuard from './auth-guard'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      authGuard: AuthGuard
    },
    {
      path: '/orders',
      name: 'Lista zamówień',
      component: Orders,
      authGuard: AuthGuard
    },
    {
      path: '/orders/add',
      name: 'Dodaj zamówienie',
      component: OrderAdd,
      authGuard: AuthGuard
    },
    {
      path: '/admin/add',
      name: 'Dodaj użytkownika',
      component: UserAdd,
      authGuard: AuthGuard
    },
    {
      path: '/signin',
      name: 'Signin',
      component: Signin
    }
  ]
})
