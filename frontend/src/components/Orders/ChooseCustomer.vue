<template>
        <v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">Wybierz kontrahenta</v-btn>
          </template>
              <template>
                <v-card>
                  <v-card-title>
                    Wybierz kontrahenta
                    <v-spacer></v-spacer>
                    <v-text-field
                      v-model="search"
                      append-icon="mdi-search"
                      label="Search"
                      single-line
                      hide-details
                    ></v-text-field>
                    <v-btn small color="primary" @click='submit'>Wybierz</v-btn>
                  </v-card-title>
                  <v-data-table
                    v-if="renderComponent"
                    :headers="headers"
                    :items="customers"
                    :search="search"
                  >
                  <template v-slot:item.checkbox="{ item }">
                    <v-checkbox v-model="item.checkbox"></v-checkbox>
                  </template>
                </v-data-table>
                </v-card>
              </template>
        </v-dialog>

</template>

<script>
import { log } from 'util';
  export default {
    data () {
      return {
        dialog: false,
        search: '',
        renderComponent: true,
        headers: [
          {
            text: '',
            align: 'left',
            sortable: false,
            value: 'checkbox'
          },
          { text: 'Firma', value: 'cu_company' },
          { text: 'NIP', value: 'cu_NIP' },
          { text: 'Imię', value: 'cu_firstName' },
          { text: 'Nazwisko', value: 'cu_lastName' },
          { text: 'E-mail', value: 'cu_email'}
       ],
      }
    },
    computed:{
      customers(){
        return this.$store.getters.customers;
      }
    },
    created(){
        this.$store.dispatch('loadCustomers')
      },
    methods:{
      submit() {
        this.$emit('submit',this.customers.filter(el => el.checkbox))
        this.close()
      },
      close () {
        this.customers.forEach(el => {
          delete el.checkbox;        
        });
        this.forceRerender()
        this.dialog = false
      },
      forceRerender() {
        // Remove my-component from the DOM
        this.renderComponent = false;
        
        this.$nextTick(() => {
          // Add the component back in
          this.renderComponent = true;
        });
      }
    },
  }
</script>


<style>

</style>