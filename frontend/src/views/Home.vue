<template>
  <v-card>
    Witaj {{user.login}}!
  </v-card>
</template>

<script>

export default {
  components: {
  },
  data () {
    return {
    }
  },
  computed: {
    user () {
      return this.$store.getters.user
    }
  }
}
</script>
