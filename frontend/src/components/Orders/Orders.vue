<template>
  <v-data-table 
    :headers="headers"
    :items="orders"
    item-key="name"
    class="elevation-1"
  ></v-data-table>

</template>

<script>
import ModalChoose from '../Shared/ModalChoose'

  export default {
    data () {
      return {
        selected: [],
        headers: [
          { text: 'ID', value: 'or_ID' },
          { text: 'customerID', value: 'or_customerID' },
          { text: 'sourceWarehouseID', value: 'or_sourceWarehouseID' },
          { text: 'targetWarehouseID', value: 'or_targetWarehouseID' },
          { text: 'status', value: 'or_status' },
          { text: 'addressID', value: 'or_addressID' },
          { text: 'shipmentID', value: 'or_shipmentID' },
          { text: 'storeID', value: 'or_storeID' },
          { text: 'creatorID', value: 'or_creatorID' },
          { text: 'createTS', value: 'or_createTS' },
          { text: 'modTS', value: 'or_modTS' },
          { text: 'modID', value: 'or_modID' },
          { text: 'comment', value: 'or_comment' },
        ],
      }
    },

    created() {
      this.$store.dispatch("loadOrders");      
    },

    computed: {
      orders() {
        return this.$store.getters.orders
      }
    }
  }
</script>


<style>

</style>