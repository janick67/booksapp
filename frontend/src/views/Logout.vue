<template>
  <v-container>
    <h1>Trwa wylogowywanie...</h1>
  </v-container>
</template>

<script>
export default {
 
 created(){
   setTimeout(() => {
      this.$store.dispatch('logout',this.$router)
   }, 500)
 },
 
}
</script>
