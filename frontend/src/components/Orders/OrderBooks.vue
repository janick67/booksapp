<template>

<v-card
    class="mx-2"
  >
  <v-card-title>Książki</v-card-title>
    <v-card-text class="text--primary">
<v-data-table
    v-if="renderComponent"
    :headers="headers"
    :items="selectedBooks"
    :hide-default-footer=true
    class="elevation-1"
  >
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Wybrane pozycje</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>
        <v-spacer></v-spacer>
        <v-btn color="primary" dark class="mb-2 mx-2" @click="calcDiscount">Przelicz rabaty</v-btn>
        <!-- <ChooseBooks  @submit="modalSubmit"/> -->
        <ModalChoose  @submit="modalSubmit" title="Wybierz ksiażki" btnText="Dodaj pozycje" :headers="booksHeaders" :rows="books"/>
      </v-toolbar>
    </template>
    <template v-slot:item.count="{ item }">
        <v-text-field
        v-model="item.count"
          ></v-text-field>
    </template>
    <template v-slot:item.sum="{ item }">
        {{calculatePrice(item).netto+' zł'}}
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
      renderComponent:true,
      dialog: false,
      headers: [
        {
          text: 'Tytuł',
          value: 'title',
        },
        { text: 'Autor', value: 'author' },
        { text: 'Wydawnictwo', value: 'printHouse' },
        { text: 'Na magazynie', value: 'stocks' },
        { text: 'Cena', value: 'price' },
        { text: 'Sztuk', value: 'count' },
        { text: 'Suma', value: 'sum' },
        { text: 'Akcja', value: 'action', sortable: false },
      ],
      selectedBooks: [],
      booksHeaders: [
          { text: '', align: 'left', sortable: false, value: 'checkbox' },
          { text: 'Tytuł', value: 'title' },
          { text: 'Autor', value: 'author' },
          { text: 'Wydawnictwo', value: 'printHouse' },
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
      this.$store.dispatch('clearActualOrder')
    },
    methods: {
      getSelectedBooks(){
        return this.selectedBooks
      },
      calculatePrice(book){
        let netto = book.price * book.count
        return {netto, gross: (netto*(123/100))}
      },
      calcDiscount(){
        console.log('przeliczam rabaty');
        this.forceRerender();
      },
      modalSubmit(books){
          books.forEach(el => {
            el.count = 1
          });

          this.selectedBooks = [...this.selectedBooks,...books];

          this.$store.dispatch('setAOSelectedBooks',this.selectedBooks)
      },
      deleteItem (item) {
        const index = this.selectedBooks.indexOf(item)
        this.selectedBooks.splice(index, 1)
      },
      forceRerender() {
        // Remove my-component from the DOM
        this.renderComponent = false;
        
        this.$nextTick(() => {
          // Add the component back in
          this.renderComponent = true;
        });
      }
    },
  }
</script>


<style>

</style>