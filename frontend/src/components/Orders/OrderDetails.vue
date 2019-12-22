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
                <v-text-field
                  v-model="showCustomer"
                  label="Klient"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                <ChooseCustomer  @submit="submitCustomer"/>
              </v-col>
              <v-col cols="12" md="4">
                <!-- <v-btn small color="primary" @click='submit'>Dodaj nowego</v-btn> -->
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
            <v-row>
              <v-col>
                <v-text-field
                  v-model="showAddress"
                  label="Adres"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                <ChooseAddress  @submit="submitAddress" :param="{delivery: this.delivery,customer: this.customer}"/>
              </v-col>
              <v-col cols="12" md="4" >
                <v-btn v-if="delivery=='Kurier'" small color="primary" @click='submit'>Dodaj nowy</v-btn>
              </v-col>
            </v-row>
            <!--<v-row>
              <v-col
                cols="12"
                md="4"
              >
                 <v-text-field
                  v-model="company"
                  label="Firma"
                  required
                ></v-text-field>
              </v-col>

              <v-col
                cols="12"
                md="4"
              >
                <v-text-field
                  v-model="nip"
                  label="NIP"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col
                cols="12"
                md="4"
              >
                <v-text-field
                  v-model="firstname"
                  label="Imię"
                  required
                ></v-text-field>
              </v-col>

              <v-col
                cols="12"
                md="4"
              >
                <v-text-field
                  v-model="lastname"
                  label="Nazwisko"
                  required
                ></v-text-field>
              </v-col>

              <v-col
                cols="12"
                md="4"
              >
                <v-text-field
                  v-model="email"
                  label="E-mail"
                  required
                ></v-text-field>
              </v-col>

            </v-row> -->
          </v-container>
        </v-form>
      </template>
    </v-card-text>
  </v-card>
</template>

<script>
import ChooseCustomer from './ChooseCustomer'
import ChooseAddress from './ChooseAddress'
    export default {
      data(){
        return {
          delivery:'Kurier',
          deliveryMethods:['Odbiór własny','Kurier'],
          customer:null,
          address:null,
        }
      },
      components:{
        ChooseCustomer,
        ChooseAddress
        },
      computed:{
        showCustomer(){
          if (this.customer !== null && typeof this.customer.cu_company != 'undefined'){
            return this.customer.cu_company
          }
          else return '---'
        },
        showAddress(){
          if (this.address !== null && typeof this.address.ad_name != 'undefined'){
            return `${this.address.ad_name} (${this.address.ad_address1})`
          }
          else return '---'
        }
      },
      methods:{
        submitCustomer(customer){
          this.customer = customer[0];
        },
        submitAddress(address){
          this.address = address[0];
        }
      }
    }
</script>


<style>

</style>