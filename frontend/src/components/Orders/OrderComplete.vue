<template>
<v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-icon
                small
                v-on="on"
            >
                mdi-check
            </v-icon>
          </template>
      <v-card>
        <v-card-title class="headline">Jesteś pewien, że chcesz zrealizować to zamówienie?</v-card-title>

        <v-card-text>
        Kliknięcie przycisku "zatwierdź" spowoduje zmianę statusu zamówienia na ZREALIZOWANO.
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="blue darken-1"
            text
            @click="back"
          >
            Anuluj
          </v-btn>

          <v-btn
            color="blue darken-1"
            text
            @click="send"
          >
            Zatwierdź
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import OrderShowVue from './OrderShow.vue';
import OrderDetailsVue from './OrderDetails.vue';

    export default {
        data () {
            return {
                dialog: false,
              
               shipmentsStatus:'w realizacji',
              
            }
        },
        computed:{
           orders(){
        return this.$store.getters.orders;
           }
      }, 
           
        created(){
            
             this.$store.dispatch('loadOrders')
        },
        props:['order'],
        methods:{
            close () {
                this.dialog = false
            },
            back(){
      this.dialog=false;
      },
   send(){
    
    
    console.log(this.order,this.order.details.id)
    const  orderId  = this.order.details.id;
 
    this.$store.dispatch('sendOrderStatus',{  orderId  }); 
   this.$store.dispatch('sendShipmentStatus',{  orderId }); 
    this.dialog = false;
    
   }
   
  
        },
    }
</script>

<style>

</style>