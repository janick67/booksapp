import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    orders: [],
    users: [],
    books: [],
    customers: [],
    addresses: [],
    warehouses: [],
    stores: [],
    actualOrder: {},
    actualUser: {},
    AOResponse: {},
    responseCreateUser: {},
    AOResponseCreateOrder: {},
    loading: false,
    user: null,
    error: null
  },
  mutations: {
    setLoadedOrders (state, payload) {
      state.orders = payload
    },
    setResponseCreateUser (state, payload) {
      state.responseCreateUser = payload
    },
    setLoadedBooks (state, payload) {
      state.books = payload
    },
    setLoadedUsers (state, payload) {
      state.users = payload
    },
    setLoadedCustomers (state, payload) {
      state.customers = payload
    },
    setLoadedAddresses (state, payload) {
      state.addresses = payload
    },
    setLoadedWarehouses (state, payload) {
      state.warehouses = payload
    },
    setLoadedStores (state, payload) {
      state.stores = payload
    },
    clearActualOrder (state) {
      state.actualOrder = {
        details: {
          id: null,
          customer: {},
          sourceWarehouse: {},
          targetWarehouse: {},
          status: 0, // 0 - nie zapisane, 1 - zapisane, 2 - w realizacji, 3 - wysałane, 4 - zrealizowane, 5 - anulowane
          address: {},
          shipment: {},
          store: {}
        },
        selectedBooks: [],
        booksSumGross: 0,
        sumGross: 0,
        confirmed: false
      }
    },
   
    setAOSelectedBooks (state, payload) {
      state.actualOrder.selectedBooks = payload
    },
    setAOBooksSumGross (state, payload) {
      state.actualOrder.booksSumGross = payload
    },
    setAOSumGross (state, payload) {
      state.actualOrder.sumGross = payload
    },
    setAODetails (state, payload) {
      state.actualOrder.details = Object.assign({}, state.actualOrder.details, payload)
    },
    createUser (state, payload) {
      state.actualUser.push(payload)
    },
    setAOConfirmed (state) {
      state.actualOrder.confirmed = true
    },
    setAOResponseCreateOrder (state, payload) {
      state.AOResponseCreateOrder = payload
    },
    setUser (state, payload) {
      state.user = payload
      //console.log(payload, typeof payload)
      if (payload !== null) payload = JSON.stringify(payload)
      localStorage.setItem('user', payload)
    },
    setLoading (state, payload) {
      state.loading = payload
    },
    setError (state, payload) {
      state.error = payload
    },
    clearError (state) {
      state.error = null
    }
  },
  actions: {
    loadOrders ({ commit }) {
      commit('setLoading', true)
      fetch('/api/orders').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedOrders', res.res)
        //console.log('jest niby ok')
        commit('setLoading', false)
      }).catch(err=>{
        console.error(err)
      })
    },
    loadBooks ({ commit }) {
      commit('setLoading', true)
      fetch('/api/books').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedBooks', res.res)
        commit('setLoading', false)
      })
    },
    loadCustomers ({ commit }) {
      commit('setLoading', true)
      fetch('/api/customers').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedCustomers', res.res)
        commit('setLoading', false)
      })
    },
    loadUsers ({ commit }) {
      commit('setLoading', true)
      fetch('/api/users').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedUsers', res.res)
        commit('setLoading', false)
      })
    },
    loadStores ({ commit }) {
      commit('setLoading', true)
      fetch('/api/stores').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedStores', res.res)
        commit('setLoading', false)
      })
    },
    loadAddresses ({ commit }) {
      commit('setLoading', true)
      fetch('/api/addresses').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedAddresses', res.res)
        commit('setLoading', false)
      })
    },
    loadWarehouses ({ commit }) {
      commit('setLoading', true)
      fetch('/api/warehouses').then(res => res.json()).then((res) => {
        if (res.error == '401') {commit('setUser',null);     return console.log('zaloguj się ponownie')}
        commit('setLoadedWarehouses', res.res)
        commit('setLoading', false)
      })
    },
    clearActualOrder ({ commit }) {
      commit('clearActualOrder')
    },
    setAOSelectedBooks ({ commit }, payload) {
      commit('setAOSelectedBooks', payload)
    },
    setAODetails ({ commit }, payload) {
      commit('setAODetails', payload)
    },
    setAUDetails ({ commit }, payload) {
      commit('setAUDetails', payload)
    },
    setAOBooksSumGross ({ commit }, payload) {
      commit('setAOBooksSumGross', payload)
    },
    setAOSumGross ({ commit }, payload) {
      commit('setAOSumGross', payload)
    },
    sendOrder ({ commit, state }, payload) {
      console.log('iam in sendorder')
      state.actualOrder.details.sale = payload;
      console.log(state.actualOrder)
      commit('setLoading', true)
      fetch('/api/orders/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(state.actualOrder)
      }).then(res => res.json()).then((res) => {
        commit('setAOResponseCreateOrder', res)
        commit('setLoading', false)
      })
    },

    sendUser ({ commit, state },payload) {
      const { loginValue, emailValue, passValue, roleValue, storeValue } = payload;
     
      commit('setLoading', true)
      fetch('/api/users/', {        method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'us_login': loginValue,
        'us_email': emailValue,
        'us_password': passValue,
        'us_roleID': roleValue,
        'us_storeID': storeValue
        })
    }).then(res => res.json()).then((res) => {
      commit('setResponseCreateUser', res.res)
      commit('setLoading', false)
    })},        
    signUserIn ({ commit }, payload) {
      commit('setLoading', true)
      commit('clearError')
      fetch('/signin/', {       
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
        body: JSON.stringify(payload)
      }).then(res => res.json()).then((res) => {
        if (res.res != null && res.err == null) {
          commit('setUser', res.res)
          commit('setLoading', false)
          console.log('zalogowałem')
        } else {
          throw res.err
        }
      }).catch(error => {
        commit('setLoading', false)
        commit('setError', error)
        console.log(error)
      })
    },
    setLocalUser ({ commit }, user) {
      commit('setUser', user)
    },
    logout ({ commit }, router) {
      fetch('/logout')
      commit('setUser', null)
      router.push('/')
    },
    clearError ({ commit }) {
      commit('clearError')
    }
  },

  getters: {
    orders (state) {
      return state.orders
    },
    books (state) {
      return state.books
    },
    stores (state) {
      return state.stores
    },
    customers (state) {
      return state.customers
    },
    users (state) {
      return state.users
    },
    addresses (state) {
      return state.addresses
    },
    warehouses (state) {
      return state.warehouses
    },
    actualOrder (state) {
      return state.actualOrder
    },
    actualUser (state) {
      return state.actualUser
  },
    user (state) {
      return state.user
    },
    loading (state) {
      return state.loading
    },
    error (state) {
      return state.error
    }
  }
})
