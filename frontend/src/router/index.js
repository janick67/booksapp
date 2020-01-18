import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/Home.vue'
import Signin from '@/views/Signin.vue'
import Orders from '@/views/Orders/Orders.vue'
import OrderAdd from '@/views/Orders/OrderAdd.vue'
import UserAdd from '@/views/Admin/UserAdd.vue'
import Logout from '@/views/Logout.vue'
import Warehouse from '@/views/Warehouses/Warehouse.vue'
import store from '@/store.js'

Vue.use(Router)

let router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: { 
        requiresAuth: true,
      }
    },
    {
      path: '/orders',
      name: 'Lista zamówień',
      component: Orders,
      meta: { 
        requiresAuth: true,
      }
    },
    {
      path: '/orders/add',
      name: 'Dodaj zamówienie',
      component: OrderAdd,
      meta: { 
        requiresAuth: true,
      }
    },
    {
      path: '/users/add',
      name: 'Dodaj użytkownika',
      component: UserAdd,
      meta: { 
        requiresAuth: true,
        is_admin : true
      }
    },
    {
      path: '/warehouse',
      name: 'Magazyn',
      component: Warehouse,
      meta: { 
        requiresAuth: true,
        is_admin : true
      }
    },
    {
      path: '/signin',
      name: 'Signin',
      component: Signin,
      meta: { 
        guest: true,
      }
    },
    {
      path: '/logout',
      name: 'Logout',
      component: Logout,
      meta: { 
        requiresAuth: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
      if (store.getters.user == null) {
          next({
              path: '/signin',
              params: { nextUrl: to.fullPath }
          })
      } else {
          let user = store.getters.user
          if(to.matched.some(record => record.meta.is_admin)) {
              if(user.roleID == 1){
                  next()
              }
              else{
                  next({ path: '/'})
              }
          }else {
              next()
          }
      }
  } else if(to.matched.some(record => record.meta.guest)) {
      if(store.getters.user == null){
          next()
      }else{
          next({ path: '/' })
      }
  }else {
      next() 
  }
})

export default router;