<template>

<v-card
    class="mx-2"
  >
  <v-card-title > Podsumowanie zamówienia </v-card-title>
    <v-card-text class="text--primary">
      <template>
        <v-form  v-if="renderComponent">
          <v-container>
            <v-row>
              <v-col>
                <v-text-field
                :value="sumUp.net"
                  label="Netto"
                  :disabled=true
                >elo</v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  :value="sumUp.gross"
                  label="Brutto"
                  :disabled=true
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </template>
    </v-card-text>
  </v-card>
</template>

<script>
    export default {
      data(){
        return {
          renderComponent: true
        }
      },
      computed:{
        actualOrder(){
          return this.$store.getters.actualOrder;
        },
        sumUp(){
          if (typeof this.actualOrder == 'undefined' || typeof this.actualOrder.booksSumGross == 'undefined' ) return {net:0,gross:0}
          let grossSum = this.actualOrder.booksSumGross;
          
          if (typeof this.actualOrder.details.customer != 'undefined' && typeof this.actualOrder.details.customer.discountValue != 'undefined'){
            grossSum -= grossSum * (this.actualOrder.details.customer.discountValue/100)
          }
          
          if (this.actualOrder.details.deliveryType == 'Kurier') grossSum += 10


          let netSum = grossSum - grossSum * (23/100)

          grossSum = Math.ceil(grossSum*100)/100
          
          netSum = Math.ceil(netSum*100)/100

          this.$store.dispatch('setAOSumGross',grossSum)
          return { gross:grossSum, net:netSum }
        }
      },
      methods:{
        forceRerender() {
        // Remove my-component from the DOM
        this.renderComponent = false;
        
        this.$nextTick(() => {
          // Add the component back in
          this.renderComponent = true;
        });
      }
      }
    }
</script>


<style>

</style>