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
        <ModalChoose  @submit="modalSubmit" title="Wybierz ksiażki" btnText="Dodaj pozycje" :headers="booksHeaders" :rows="books"/>
      </v-toolbar>
    </template>
    <template v-slot:item.count="{ item }">
        <v-text-field
        v-model="item.count"
        @change="forceRerender"
          ></v-text-field>
    </template>
    <template v-slot:item.sum="{ item }">
        {{calculatePrice(item).gross+' zł'}}
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
import OrderSumUpVue from './OrderSumUp.vue';
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
      calculatePrice(book){
        let gross = book.price * book.count;
        gross -= gross * (book.discountValue/100);
        let net = gross - (gross*(23/100))
        return {net, gross}
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
          this.forceRerender()
      },
      deleteItem (item) {
        const index = this.selectedBooks.indexOf(item)
        this.selectedBooks.splice(index, 1)
      },
      sumUp(){
          let grossSum = 0;
          this.selectedBooks.forEach(el=>{
            let gross = el.price * el.count;
            gross -= gross * (el.discountValue/100);
            grossSum += gross;
          })
          
          let netSum = grossSum - (grossSum*(23/100));
          netSum = Math.ceil(netSum*100)/100
          grossSum = Math.ceil(grossSum*100)/100
          this.$store.dispatch('setAOBooksSumGross',grossSum)
        },
      forceRerender() {
        // Remove my-component from the DOM
        this.renderComponent = false;
        this.$store.dispatch('setAOSelectedBooks',this.selectedBooks)

        this.$nextTick(() => {
          // Add the component back in
          this.renderComponent = true;
        });

        this.sumUp()
      }
    },
  }
</script>


<style>

</style>