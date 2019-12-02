// import store from '../store'

export default (to, from, next) => {
  next()

  if (this.$store.getters.user) {
    next()
  } else {
    next('/signin')
  }
}
