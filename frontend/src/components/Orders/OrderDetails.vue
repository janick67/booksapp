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
                <ChooseCustomer  @submit="modalSubmit"/>
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
            <v-row v-if="delivery=='Kurier'">
              <v-col>
                <v-text-field
                  v-model="address"
                  label="Adres"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="4">
                <v-btn small color="primary" @click='submit'>Wybierz istniejący</v-btn>
              </v-col>
              <v-col cols="12" md="4">
                <v-btn small color="primary" @click='submit'>Dodaj nowy</v-btn>
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
    export default {
      data(){
        return {
          delivery:null,
          deliveryMethods:['Odbiór własny','Kurier'],
          customer:null,
        }
      },
      components:{
        ChooseCustomer
        },
      computed:{
        showCustomer(){
          if (this.customer !== null && typeof this.customer.cu_company != 'undefined'){
            return this.customer.cu_company
          }
          else return '---'
        }
      },
      methods:{
        modalSubmit(customer){
          console.log('no elo z wyboru klienta',customer);
          this.customer = customer[0];
        }
      }
    }
</script>


<style>

</style>