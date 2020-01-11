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
                <v-text-field v-model="autoCustomer.company" label="Klient" :disabled=true></v-text-field>
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
                <v-text-field v-model="autoStore.name" label="Filia" :disabled=true></v-text-field>
              </v-col>
              <v-col>
                <v-text-field v-model="autoSourceWarehouse.code" label="Magazyn" :disabled=true></v-text-field>
              </v-col>
              <v-col v-if="deliveryType=='Kurier'">
                <ModalChoose  
                  @submit="submitSourceWarehouse"
                  title="Wybierz magazyn"
                  btnText="Wybierz magazyn"
                  :headers="sourceWarehouseHeaders"
                  :rows="sourceWarehouses"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" md="4">
                <v-combobox
                v-model="deliveryType"
                :items="deliveryMethods"
                label="Sposób dostawy"
              ></v-combobox>
              </v-col>
              
            </v-row>
            <v-row v-if="deliveryType=='Kurier'">
              <v-col>
                <v-text-field v-model="showAddress" label="Adres" :disabled=true></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                 <ModalChoose @submit="submitAddress" title="Wybierz adres" btnText="Wybierz adres" 
                 :headers="addressHeaders" :rows="addresses" ></ModalChoose>
              </v-col>
              <v-col cols="13" md="5" >
                 <ModalInput @submit="submitAddress" title="Dodaj nowy adres" btnText="Dodaj nowy adres" 
                 :headers="addressHeaders" :rows="addAddresses" ></ModalInput>

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
import ModalInput from '../Shared/ModalInput'

export default {
      data(){
        return {
          deliveryType:'Kurier',
          deliveryMethods:['Odbiór własny','Kurier'],
          customer:null,
          address:{},
          sourceWarehouse:null,
          customerHeaders: [
              {text: '', align: 'left', sortable: false, value: 'checkbox' },
              { text: 'Firma', value: 'company' },
              { text: 'NIP', value: 'nip' },
              { text: 'Imię', value: 'firstName' },
              { text: 'Nazwisko', value: 'lastName' },
              { text: 'E-mail', value: 'email'}],
        
        
          addressHeaders: [
            { text: '', align: 'left', sortable: false, value: 'checkbox' },
            { text: 'Nazwa', value: 'name' },
            { text: 'Miasto', value: 'city' },
            { text: 'Kod pocztowy', value: 'postalCode' },
            { text: 'Adres', value: 'address1' },
            { text: 'Adres 2', value: 'address2'}],
            
          sourceWarehouseHeaders: [
            { text: '', align: 'left', sortable: false, value: 'checkbox' },
            { text: 'Kod', value: 'code' },
            { text: 'Miasto', value: 'city' }]
       }
      },
      components:{
        ModalChoose, 
        ModalInput
        },
      mounted(){
          this.$store.dispatch('loadCustomers')
          this.$store.dispatch('loadAddresses')
          this.$store.dispatch('loadWarehouses')
          this.$store.dispatch('loadAddAddresses')

          
        },
        updated(){
          this.$store.dispatch('setAODetails',{customer: this.autoCustomer, sourceWarehouse: this.autoSourceWarehouse, store: this.autoStore, address: this.address, deliveryType: this.deliveryType})
        },
      computed:{
        customers(){
          return this.$store.getters.customers; 
        },
        addresses(){
          return this.$store.getters.addresses.filter(el => {
            if (this.customer != null)
            return el.customerID == this.customer.id
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
          if (this.store !== null && typeof this.store.name != 'undefined'){
            return this.store
          }
          else return {st_name:'---'} 
        },
        autoCustomer(){
          if (this.customer !== null && typeof this.customer !== 'undefined' && typeof this.customer.company !== 'undefined'){
            return this.customer
          }
          else return {company:'---'}
        },
        autoSourceWarehouse(){
          if (this.sourceWarehouse !== null && typeof this.sourceWarehouse.code != 'undefined'){
            return this.sourceWarehouse
          }
          else if (this.store != null && this.sourceWarehouses != null){
            let out = this.sourceWarehouses.find(el=> el.id = this.store.warehouseID);
            if (typeof out !== 'undefined')
              return out 
          }
          return {wa_code:'---'}
        },
        showAddress(){
          if (this.address !== null && typeof this.address.name != 'undefined'){
            return `${this.address.name} (${this.address.address1})`
          }
          else return '---'
        }
      },
      watch:{
        store: function(newStore,oldStore) {
          if (this.address == null)
          this.addresses = addresses.find( el => el.id = newStore.addressID)
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
        getDetails(){
          console.log('this.deliveryMethods',this.deliveryMethods)
          return {
            customer: this.deliveryMethods
          }
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