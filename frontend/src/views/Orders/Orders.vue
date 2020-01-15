<template>
  <v-card class="mx-2">
    <v-card-title>Lista zamówień</v-card-title>
    <v-card-text class="text--primary">
      <v-data-table
        v-if="renderComponent"
        :headers="headers"
        :items="orders"
        class="elevation-1"
      >
        <template v-slot:item.details.customerID="{ item }">
          {{ showCustomer(item.details.customerID) }}
        </template>
        <template v-slot:item.details.status="{ item }">
          {{ showStatus(item.details.status) }}
        </template>
        <template v-slot:item.details.createTS="{ item }">
          {{ item.details.createTS | date }}
        </template>
        <template v-slot:item.action="{ item }">
          <OrderShow :order="item" />
        </template>
        <template v-slot:item.action1 ="{ item }">
          <TrackingNumber :order="item" />
        </template>
        <template v-slot:item.action2="{ item }">
          <OrderShow :order="item" />
        </template>
      </v-data-table>
    </v-card-text>
  </v-card>
</template>

<script>
import OrderShow from '@/components/Orders/OrderShow';
import TrackingNumber from '@/components/Orders/TrackingNumber';

export default {
  components: {
    OrderShow,
    TrackingNumber
  },
  data: () => ({
    renderComponent: true,
    headers: [
      { text: 'Id', value: 'details.id' },
      { text: 'Kontrahent', value: 'details.customerID' },
      { text: 'Do zapłaty', value: 'details.sumGross' },
      { text: 'Status', value: 'details.status' },
      { text: 'Data utworzenia', value: 'details.createTS' },
      { text: 'Użytkownik', value: 'details.creatorID' },
      { text: 'Akcja', value: 'action', sortable: false },
      { text: 'Akcja1', value: 'action1', sortable: false },
      { text: 'Akcja2', value: 'action2', sortable: false }
    ]
  }),
  computed: {
    orders() {
      return this.$store.getters.orders;
    },
    customers() {
      return this.$store.getters.customers;
    }
  },
  mounted() {
    this.$store.dispatch('loadOrders');
    this.$store.dispatch('loadCustomers');
  },
  methods: {
    showOrder(item) {
      console.log(item);
    },
    showStatus(status) {
      switch (status) {
        //0 - nie zapisane, 1 - zapisane, 2 - w realizacji, 3 - wysałane, 4 - zrealizowane, 5 - anulowane
        case 0:
          return 'nie zapisane';
          break;
        case 1:
          return 'zapisane';
          break;
        case 2:
          return 'w realizacji';
          break;
        case 3:
          return 'wysłane';
          break;
        case 4:
          return 'zrealizowane';
          break;
        case 5:
          return 'anulowane';
          break;
        default:
          return 'nieustalony';
          break;
      }
    },
    showCustomer(id) {
      let customer = this.customers.find(el => {
        return el.id == id;
      });
      if (
        typeof customer == 'undefined' ||
        typeof customer.company == 'undefined'
      )
        return '---';
      return customer.company;
    }
  }
};
</script>

<style></style>
