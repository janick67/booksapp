<template>
<div> 
    <h1>Dodaj zamówienie</h1>
    <div v-if="!sale&&!internal">
        Jakie zamówienie chcesz dodać?<br/>
        <v-btn color="primary" @click="makeSale">Sprzedaży</v-btn><br/><br/>
        <v-btn color="primary" @click="makeInternal">Wewnętrzne</v-btn>
    </div>
    <div v-else>

        <ChooseBooks/>
    </div>
</div>
</template>

<script>
    import ChooseBooks from '@/components/Orders/ChooseBooks'

    export default {
        components: {
            ChooseBooks
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
            }
        }
    }
</script>

<style>

</style>