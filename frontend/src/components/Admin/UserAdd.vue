<template>

<v-card
    class="mx-2"
  >
  <v-card-title>Użytkownicy w systemie</v-card-title>
    <v-card-text class="text--primary">
<v-data-table
    :headers="headers"
    :items="desserts"
    :hide-default-footer=true
    class="elevation-1"
  >
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Użytkownik</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>
        <v-spacer></v-spacer>
        <ModalChoose  @submit="modalSubmit" title="Wybierz ksiażki" btnText="Dodaj nowego" :headers="booksHeaders" :rows="books"/>
      </v-toolbar>
    </template>
    <template v-slot:item.count="{ item }">
        <v-text-field
        value="1"
          ></v-text-field>
    </template>
    <template v-slot:item.action="{ item }">
      <v-icon
        small
        @click="deleteItem(item)"
      >
        mdi-delete
      </v-icon>
    </template>
  </v-data-table>
    </v-card-text>
  </v-card>
</template>

<script>
import ModalChoose from '../Shared/ModalChoose'
  export default {
    data: () => ({
      dialog: false,
      headers: [
        {
          text: 'Tytuł',
          value: 'bo_title',
        },
        { text: 'Autor', value: 'bo_author' },
        { text: 'Wydawnictwo', value: 'bo_printHouse' },
        { text: 'Na magazynie', value: 'stocks' },
        { text: 'Cena', value: 'bo_price' },
        { text: 'Sztuk', value: 'count', sortable: false },
        { text: 'Akcja', value: 'action', sortable: false },
      ],
      desserts: [],
      booksHeaders: [
          { text: '', align: 'left', sortable: false, value: 'checkbox' },
          { text: 'Tytuł', value: 'bo_title' },
          { text: 'Autor', value: 'bo_author' },
          { text: 'Wydawnictwo', value: 'bo_printHouse' },
          { text: 'Na magazynie', value: 'stocks' },],
    }),
    components:{
      ModalChoose
    },
    computed:{
      books(){
        return this.$store.getters.books;
      }      
    },
    mounted(){
      this.$store.dispatch('loadBooks')
    },
    methods: {
      generateOrderJSON(){
        
      },
      
      modalSubmit(el){
          this.desserts = [...this.desserts,...el];
      },
      deleteItem (item) {
        const index = this.desserts.indexOf(item)
        this.desserts.splice(index, 1)
      },
    },
  }
</script>


<style>

</style>