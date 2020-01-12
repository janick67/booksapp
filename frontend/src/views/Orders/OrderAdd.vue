<template>
<div> 
    <h1>Dodaj zamówienie</h1>
    <div v-if="!sale&&!internal">
        Jakie zamówienie chcesz dodać?<br/>
        <v-btn color="primary" @click="makeSale">Sprzedaży</v-btn><br/><br/>
        <v-btn color="primary" @click="makeInternal">Wewnętrzne</v-btn>
    </div>
    <div v-else>
        <OrderBooks @change="changeOrderBooks" class="ma-2"/>
        <OrderDetails class="ma-2"/>
        <OrderSumUp class="ma-2"/>
    </div>
    <v-btn color="primary" @click="nextForm" to="/orders" class="ma-2">Wyślij</v-btn>
</div>
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
                sale: true,
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
            nextForm(){
                this.$store.dispatch('sendOrder')
            },
            changeOrderBooks(){
                OrderSumUp.methods.forceRerender()
            }
        }
    }
</script>

<style>

</style>