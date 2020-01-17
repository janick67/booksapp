<template>
<v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-icon
                small
                v-on="on"
            >
                mdi-truck
            </v-icon>
          </template>
          <template>
               <v-card>
        <v-card-title>
          <span class="headline">Wprowadź numer przesyłki</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6" md="4">
                <v-text-field label="Numer przesyłki" v-model="trackingNumber" required></v-text-field>
              </v-col>
            <v-col cols="12" sm="6" md="4">
                <v-text-field label="Typ wysyłki" v-model="shipmentsType" required></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="back">Wróć</v-btn>
          <v-btn color="blue darken-1" text @click="send" >Zapisz</v-btn >
        </v-card-actions>
      </v-card>
      </template>
        </v-dialog>
</template>

<script>
export default {
  data () {
    return {
      dialog: false,
      trackingNumber: '',
      shipmentsStatus: 'w realizacji',
      shipmentsType: ''
    }
  },
  computed: {
    orders () {
      return this.$store.getters.orders
    }
  },
  created () {
    this.$store.dispatch('loadOrders')
  },
  props: ['order'],
  methods: {
    close () {
      this.dialog = false
    },
    back() {
      this.dialog=false;
      },
   send(){
    
    const { trackingNumber, shipmentsId  , shipmentsStatus, shipmentsType } = this;
    console.log(this.order,this.order.details.id)
    const  orderId  = this.order.details.id;
 
    this.$store.dispatch('sendShipments',{ trackingNumber, orderId, shipmentsStatus, shipmentsType }); 
   this.$store.dispatch('sendStatus',{ trackingNumber, orderId, shipmentsStatus, shipmentsType }); 
    this.dialog = false;
   
    
   
        
   }
        },
    }
</script>

<style>

</style>