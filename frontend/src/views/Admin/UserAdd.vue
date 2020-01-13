<template>
<div> 
      <h1>Dodaj użytkownika</h1>

</div>
</template>

<script>
    export default {
        data(){
            return {
                sale: true,
                internal: false,
                books:[]
            }
        },
        mounted(){
            this.$store.dispatch('loadStores')
        }
    }
</script>

<style>

</style>