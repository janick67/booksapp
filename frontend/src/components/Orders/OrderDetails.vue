<template>

<v-card
    class="mx-2"
  >
  <v-card-title > Szczegóły zamówienia </v-card-title>
    <v-card-text class="text--primary">
      <template>
        <v-form >
          <v-container>
            <v-row>
              <v-col cols="12" md="4">
                <v-text-field v-model="autoCustomer.cu_company" label="Klient" :disabled=true></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                <ModalChoose  @submit="submitCustomer" title="Wybierz kontrahenta" btnText="Wybierz kontrahenta" :headers="customerHeaders" :rows="customers"/>
              </v-col>
              <v-col cols="12" md="4">
                 <v-btn small color="primary" @click='addCustomer'>Dodaj nowego</v-btn>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-text-field v-model="autoStore.st_name" label="Filia" :disabled=true></v-text-field>
              </v-col>
              <v-col>
                <v-text-field v-model="autoSourceWarehouse.wa_code" label="Magazyn" :disabled=true></v-text-field>
              </v-col>
              <v-col v-if="delivery=='Kurier'">
                <ModalChoose  @submit="submitSourceWarehouse" title="Wybierz magazyn" btnText="Wybierz magazyn" :headers="sourceWarehouseHeaders" :rows="sourceWarehouses"/>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" md="4">
                <v-combobox
                v-model="delivery"
                :items="deliveryMethods"
                label="Sposób dostawy"
              ></v-combobox>
              </v-col>
              
            </v-row>
            <v-row v-if="delivery=='Kurier'">
              <v-col>
                <v-text-field v-model="showAddress" label="Adres" :disabled=true></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                 <ModalChoose @submit="submitAddress" title="Wybierz adres" btnText="Wybierz adres" :headers="addressHeaders" :rows="addresses" ></ModalChoose>
              </v-col>
              <v-col cols="12" md="4" >
                <v-btn small color="primary" @click='addAddress'>Dodaj nowy</v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </template>
    </v-card-text>
  </v-card>
</template>

<script>
import ModalChoose from '../Shared/ModalChoose'

export default {
      data(){
        return {
          delivery:'Kurier',
          deliveryMethods:['Odbiór własny','Kurier'],
          customer:null,
          address:null,
          sourceWarehouse:null,
          customerHeaders: [
              {text: '', align: 'left', sortable: false, value: 'checkbox' },
              { text: 'Firma', value: 'cu_company' },
              { text: 'NIP', value: 'cu_NIP' },
              { text: 'Imię', value: 'cu_firstName' },
              { text: 'Nazwisko', value: 'cu_lastName' },
              { text: 'E-mail', value: 'cu_email'}],
        
        
          addressHeaders: [
            { text: '', align: 'left', sortable: false, value: 'checkbox' },
            { text: 'Nazwa', value: 'ad_name' },
            { text: 'Miasto', value: 'ad_city' },
            { text: 'Kod pocztowy', value: 'ad_postalCode' },
            { text: 'Adres', value: 'ad_address1' },
            { text: 'Adres 2', value: 'ad_address2'}],
            
          sourceWarehouseHeaders: [
            { text: '', align: 'left', sortable: false, value: 'checkbox' },
            { text: 'Kod', value: 'wa_code' },
            { text: 'Miasto', value: 'ad_city' }]
       }
      },
      components:{
        ModalChoose
        },
      mounted(){
          this.$store.dispatch('loadCustomers')
          this.$store.dispatch('loadAddresses')
          this.$store.dispatch('loadWarehouses')
        },
      computed:{
        customers(){
          return this.$store.getters.customers; 
        },
        addresses(){
          return this.$store.getters.addresses.filter(el => {
            if (this.customer != null)
            return el.ca_customerID == this.customer.cu_ID
            return false;
          });
        },
        sourceWarehouses(){
          return this.$store.getters.warehouses; 
        },
        store(){
          return this.$store.getters.user.store
        },
        autoStore(){
          if (this.store !== null && typeof this.store.st_name != 'undefined'){
            return this.store
          }
          else return {st_name:'---'} 
        },
        autoCustomer(){
          if (this.customer !== null && typeof this.customer.cu_company != 'undefined'){
            return this.customer
          }
          else return {cu_company:'---'}
        },
        autoSourceWarehouse(){
          if (this.sourceWarehouse !== null && typeof this.sourceWarehouse.wa_code != 'undefined'){
            return this.sourceWarehouse
          }
          else if (this.store != null && this.sourceWarehouses != null){
            let out = this.sourceWarehouses.find(el=> el.wa_id = this.store.st_warehouseID);
            if (typeof out !== 'undefined')
              return out 
          }
          return {wa_code:'---'}
        },
        showAddress(){
          if (this.address !== null && typeof this.address.ad_name != 'undefined'){
            return `${this.address.ad_name} (${this.address.ad_address1})`
          }
          else return '---'
        }
      },
      watch:{
        store: function(newStore,oldStore) {
          if (this.address == null)
          this.addresses = addresses.find( el => el.ad_id = newStore.st_addressID)
          console.log("wyliczam address po zmianie store");
        }
      },
      methods:{
        submitCustomer(payload){
          this.customer = payload[0];
        },
        submitAddress(payload){
          this.address = payload[0];
        },
        submitSourceWarehouse(payload){
          this.sourceWarehouse = payload[0];
        },
        addAddress(){
          console.log("tutaj modal który pozwala na dodanie nowego adresu");
        },
        addCustomer(){
          console.log("tutaj modal który pozwala na dodanie nowego kontrahenta");
        }
      }
    }
</script>


<style>

</style>