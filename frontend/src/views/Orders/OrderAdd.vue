<template>
<v-card
    class="ma-2"
  >
  <v-card-title>Dodaj zamówienie</v-card-title>
    <v-card-text class="text--primary">
        <div v-if="!sale&&!internal">
            <h4 class="ma-2">Jakie zamówienie chcesz dodać?</h4>
            <v-btn class="ma-2" color="primary" @click="makeSale">Sprzedaży</v-btn><br/>
            <v-btn class="ma-2" color="primary" @click="makeInternal">Wewnętrzne</v-btn>
        </div>
        <div v-else>
            <OrderBooks @change="changeOrderBooks" class="ma-2" :sale="sale"/>
            <OrderDetails class="ma-2" :sale="sale"/>
            <OrderSumUp class="ma-2" :sale="sale"/>
            <v-btn color="primary" @click="send" class="ma-2">Wyślij</v-btn>
        </div>
    </v-card-text>
  </v-card>
</template>

<script>
    import OrderBooks from '@/components/Orders/OrderBooks'
    import OrderDetails from '@/components/Orders/OrderDetails'
    import OrderSumUp from '@/components/Orders/OrderSumUp'

    export default {
        components: {
            OrderBooks,
            OrderDetails,
            OrderSumUp
        },
        data(){
            return {
                sale: false,
                internal: false,
                books:[]
            }
        },
        methods:{
            makeSale(){
                this.sale = true;
                this.internal = false;
            },
            makeInternal(){
                this.sale = false;
                this.internal = true;
            },
            send(){
                console.log('iam before sendorder')
                this.$store.dispatch('sendOrder', this.sale)
                //to="/orders" //TODO
            },
            changeOrderBooks(){
                OrderSumUp.methods.forceRerender()
            }
        }
    }
</script>

<style>

</style>