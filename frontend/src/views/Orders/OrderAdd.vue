<template>
<v-container>
    <v-layout row v-if="error">
      <v-flex xs12 sm6 offset-sm3>
        <v-alert type="error">
        {{error.message}}
      </v-alert>
      </v-flex>
    </v-layout>
<v-card
    class="mx-2"
  >
  <v-card-title>Dodaj zamówienie</v-card-title>
    <v-card-text class="text--primary">
        <div v-if="!sale&&!internal">
            <h4 class="ma-2">Jakie zamówienie chcesz dodać?</h4>
            <v-btn class="ma-2" color="primary" @click="makeSale">Sprzedaży</v-btn><br/>
            <v-btn class="ma-2" color="primary" @click="makeInternal">Wewnętrzne</v-btn>
        </div>
        <div v-else>
            <OrderBooks @change="changeOrderBooks" class="ma-2" :sale="sale"/>
            <OrderDetails class="ma-2" :sale="sale"/>
            <OrderSumUp class="ma-2" :sale="sale"/>
            <v-btn color="primary" @click="send" class="ma-2">Wyślij</v-btn>
        </div>
    </v-card-text>
  </v-card>
  </v-container>
</template>

<script>
import OrderBooks from '@/components/Orders/OrderBooks'
import OrderDetails from '@/components/Orders/OrderDetails'
import OrderSumUp from '@/components/Orders/OrderSumUp'

export default {
  components: {
    OrderBooks,
    OrderDetails,
    OrderSumUp
  },
  data () {
    return {
      sale: false,
      internal: false,
      books: []
    }
  },
  computed: {
    response () {
      return this.$store.getters.AOResponseCreateOrder
    },
    error () {
      return this.$store.getters.error
    }
  },
  watch: {
    response (value) {
      console.log('odp.:', this.response)
      if (this.response !== null && this.response !== undefined && this.response.id !== undefined) {
        if (this.response.id !== null) this.$router.push('/orders')
      }
    }
  },
  methods: {
    makeSale () {
      this.sale = true
      this.internal = false
    },
    makeInternal () {
      this.sale = false
      this.internal = true
    },
    send () {
      console.log('iam before sendorder')
      this.$store.dispatch('clearAOResponseCreateOrder')
      this.$store.dispatch('sendOrder', this.sale)
      // to="/orders" //TODO
    },
    changeOrderBooks () {
      OrderSumUp.methods.forceRerender()
    }
  }
}
</script>

<style>

</style>
