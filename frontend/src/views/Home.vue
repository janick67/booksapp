<template>
  <v-card>
    <v-tabs v-model="tab" grow
    show-arrows
    >
      <v-tab v-for="item in tabs" :key="item">
        {{ item }}
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item
        v-for="item in tabs"
        :key="item">
        <v-card flat >
          <v-card-text>
            {{orders}}
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
</template>

<script>

export default {
  components: {
  },
  data () {
    return {
      tabs: ['Wszystkie', 'Wydatki', 'Przychody', 'Pożyczki', 'Długi', 'Przelewy'],
      tab: 0,
      selected: []
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
