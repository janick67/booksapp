<template>
  <v-card class="mx-2">
    <v-card-title> Magazyn</v-card-title>
    <v-card-text class="text--primary">
      <v-data-table
        v-if="renderComponent"
        :headers="headers"
        :items="warehouse"
        :hide-default-footer="true"
        class="elevation-1"
      >
        <template v-slot:top>
          <v-toolbar flat color="white">
            <v-toolbar-title>Nasze magazyny</v-toolbar-title>
           
            <v-spacer></v-spacer>
           
         

          </v-toolbar>
        </template>
        <template v-slot:item.count="{ item }">
          <v-text-field v-model="item.count"></v-text-field>
        </template>
        <template v-slot:item.action="{ item }">
          <v-icon small @click="deleteItem(item)">
            mdi-delete
          </v-icon>
        </template>
      </v-data-table>
    </v-card-text>
  </v-card>
</template>

<script>

export default {
  data: () => ({
    renderComponent: true,
    dialog: false,
    headers: [
      {text: 'Nazwa magazynu',value: 'code'},
      {text: 'Adres', value: 'city'},
    ]
  }),
  components: {
  
  },
  computed: {
    warehouse() {
      console.log(this.$store.getters);
      
      return this.$store.getters.warehouses;
    },
    books() {
      return this.$store.getters.books;
    }
  },
  created() {
    this.$store.dispatch('loadWarehouses');
    this.$store.dispatch('loadWarehousesBooks');
  },
  methods: {
    forceRerender() {
      // Remove my-component from the DOM
      this.renderComponent = false;

      this.$nextTick(() => {
        // Add the component back in
        this.renderComponent = true;
      });
    }
  }
};
</script>

<style></style>
