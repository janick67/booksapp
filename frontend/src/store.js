import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    orders: [],
    books: [],
    customers: [],
    addresses: [],
    warehouses: [],
    actualOrder: {},
    AOResponse: {},
    loading: false
    // user: null,
    // error: null
  },
  mutations: {
    setLoadedOrders (state, payload) {
      state.orders = payload
    },
    setLoadedBooks (state, payload) {
      state.books = payload
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
        details: {},
        selectedBooks: {},
        confirmed: false
      }
    },
    setAOSelectedBooks (state, payload) {
      state.actualOrder.selectedBooks = payload
    },
    setAODetails (state, payload) {
      state.actualOrder.details = payload
    },
    setAOConfirmed (state) {
      state.actualOrder.confirmed = true
    },
    setAOResponse (state, payload){
      state.AOResponse = payload
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
    sendOrder ({ commit, state }) {
      commit('setLoading', true)
      fetch('/api/orders/', {
        method: 'POST', // or 'PUT'
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(state.actualOrder)
      }).then(res => res.json()).then((res) => {
        commit('setResponseCreateOrder', res.res)
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
    addresses (state) {
      return state.addresses
    },
    warehouses (state) {
      return state.warehouses
    },
    actualOrder (state) {
      return state.actualOrder
    },
    user (state) {
      return { user: 'test', store: { st_name: 'Zabornia', st_short: 'Zabo', st_addressID: '10', st_warehouseID: '1' } }
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
