<template>
        <v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">Wybierz adres</v-btn>
          </template>
              <template>
                <v-card>
                  <v-card-title>
                    Wybierz adres
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
                    :items="address"
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
          { text: 'Nazwa', value: 'ad_name' },
          { text: 'Miasto', value: 'ad_city' },
          { text: 'Kod pocztowy', value: 'ad_postalCode' },
          { text: 'Adres', value: 'ad_address1' },
          { text: 'Adres 2', value: 'ad_address2'}
       ],
      }
    },
    computed:{
      address(){
        return this.$store.getters.address.filter(el => {
          if (this.param.customer != null)
          return el.ca_customerID == this.param.customer.cu_ID
          return false;
        });
      }
    },
    props:['param'],
    created(){
        this.$store.dispatch('loadAddress')
      },
    methods:{
      submit() {
        this.$emit('submit',this.address.filter(el => el.checkbox))
        this.close()
      },
      close () {
        this.address.forEach(el => {
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