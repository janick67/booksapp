import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    orders: [],
    loading: false
    // user: null,
    // error: null
  },
  mutations: {
    setLoadedOrders (state, payload) {
      state.orders = payload
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
      return [
        {
          id: 1,
          title: 'Harry Potter',
          author: 'J.K',
          print: 'PTW',
          prize: 15,
          stocks: 4
        },
        {
          id: 2,
          title: 'GOT',
          author: 'J.K',
          print: 'PTW',
          prize: 15,
          stocks: 4
        }
      ]
    },
    user (state) {
      return { user: 'test' }
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
