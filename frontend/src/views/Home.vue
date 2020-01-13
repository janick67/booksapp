<template>
  <v-card>
    
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
    orders() {
      let tab = this.tab
      let orders = this.$store.getters.orders
      
      return orders;
    }
  }
}
</script>
