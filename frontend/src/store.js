import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    orders: [],
    users: [],
    store: [],
    books: [],
    customers: [],
    addresses: [],
    warehouses: [],
    actualOrder: {},
    actualUser: {},
    AOResponse: {},
    responseCreateUser: {},
    AOResponseCreateOrder: {},
    loading: false
    // user: null,
    // error: null
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
    setLoadedStore (state, payload) {
      state.store = payload
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
    // setUser (state, payload) {
    //   state.user = payload
    //   this.dispatch('loadRows')
    // },
    setLoading (state, payload) {
      state.loading = payload
    }
    // setError (state, payload) {
    //   state.error = payload
    // },
    // clearError (state) {
    //   state.error = null
    // }
  },
  actions: {

   
    loadOrders ({ commit }) {
      commit('setLoading', true)
      fetch('/api/orders').then(res => res.json()).then((res) => {
        commit('setLoadedOrders', res.res)
        commit('setLoading', false)
      })
    },
    loadBooks ({ commit }) {
      commit('setLoading', true)
      fetch('/api/books').then(res => res.json()).then((res) => {
        commit('setLoadedBooks', res.res)
        commit('setLoading', false)
      })
    },
    loadCustomers ({ commit }) {
      commit('setLoading', true)
      fetch('/api/customers').then(res => res.json()).then((res) => {
        commit('setLoadedCustomers', res.res)
        commit('setLoading', false)
      })
    },
    loadUsers ({ commit }) {
      commit('setLoading', true)
      fetch('/api/users').then(res => res.json()).then((res) => {
        commit('setLoadedUsers', res.res)
        commit('setLoading', false)
      })
    },
    loadStore ({ commit }) {
      commit('setLoading', true)
      fetch('/api/store').then(res => res.json()).then((res) => {
        commit('setLoadedStore', res.res)
        commit('setLoading', false)
      })
    },
    loadAddresses ({ commit }) {
      commit('setLoading', true)
      fetch('/api/addresses').then(res => res.json()).then((res) => {
        commit('setLoadedAddresses', res.res)
        commit('setLoading', false)
      })
    },
    loadWarehouses ({ commit }) {
      commit('setLoading', true)
      fetch('/api/warehouses').then(res => res.json()).then((res) => {
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
    sendOrder ({ commit, state }) {
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

      console.log('store console',payload)
      const { loginValue, emailValue, passValue, roleValue, storeValue } = payload;
     
      commit('setLoading', true)
      fetch('/api/users/', {
        method: 'POST',
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
      })
    }
    // signUserUp ({ commit }, payload) {
    //   commit('setLoading', true)
    //   commit('clearError')
    //   firebase.auth().createUserWithEmailAndPassword(payload.email, payload.password)
    //     .then(
    //       user => {
    //         commit('setLoading', false)
    //         const newUser = {
    //           id: user.uid,
    //           email: payload.email
    //         }
    //         commit('setUser', newUser)
    //       }
    //     )
    //     .catch(
    //       error => {
    //         commit('setLoading', false)
    //         commit('setError', error)
    //         console.log(error)
    //       }
    //     )
    // },
    // signUserIn ({ commit }, payload) {
    //   commit('setLoading', true)
    //   commit('clearError')
    //   firebase.auth().signInWithEmailAndPassword(payload.email, payload.password)
    //     .then(
    //       user => {
    //         commit('setLoading', false)
    //         const newUser = {
    //           id: user.uid,
    //           email: payload.email
    //         }
    //         commit('setUser', newUser)
    //       }
    //     )
    //     .catch(
    //       error => {
    //         commit('setLoading', false)
    //         commit('setError', error)
    //         console.log(error)
    //       }
    //     )
    // },
    // autoSignIn ({ commit }, payload) {
    //   commit('setUser', { id: payload.uid, email: payload.email })
    // },
    // logout ({ commit }) {
    //   firebase.auth().signOut()
    //   commit('setUser', null)
    // },
    // clearError ({ commit }) {
    //   commit('clearError')
    // }
  },

  getters: {
    orders (state) {
      return state.orders
    },
    books (state) {
      return state.books
    },
    customers (state) {
      return state.customers
    },
    users (state) {
      return state.users
    },
    store (state) {
      return state.store
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
      return { user: 'test', store: { id: 1, name: 'Zabornia', short: 'Zabo', addressID: '10', warehouseID: '1' } }
      // return state.user
    },
    loading (state) {
      return state.loading
    },
    error (state) {
      return state.error
    }
  }
})
