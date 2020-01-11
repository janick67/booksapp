<template>
<v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-icon
                small
                v-on="on"
            >
                mdi-eye
            </v-icon>
          </template>
          <template>
              <v-card>
                  <v-card-title>
                      Podgląd zamówienia
                  </v-card-title>
                        <v-card class="pa-5">
                            <v-card-title>
                                Książki
                            </v-card-title>
                            <v-data-table
                                :headers="booksHeaders"
                                :items="orderBooks"
                                :hide-default-footer=true
                            >
                            </v-data-table>
                        </v-card>
                    </v-card>
                </template> 
        </v-dialog>
</template>

<script>

    export default {
        data () {
            return {
                dialog: false,
                booksHeaders: [
                    { text: 'Tytuł', value: 'title', sortable: false },
                    { text: 'Autor', value: 'author', sortable: false },
                    { text: 'Wydawnictwo', value: 'printHouse', sortable: false },
                    { text: 'Sztuk', value: 'count', sortable: false },],
            }
        },
        computed:{
            books(){
                return this.$store.getters.books;
            },
            orderBooks(){
                let booksTab=[];
                if (this.books.length == 0) return [];
                this.order.books.forEach(orderBook => {
                    let book = this.books.find(book => orderBook.bookID == book.id);
                    if (typeof book == 'undefined') {console.log('nieznaleziono',orderBook.bookID); return 0;}
                    book.count = orderBook.count;
                    booksTab.push(book)
                });
                return booksTab;
            }
        },
        mounted(){
            this.$store.dispatch('loadBooks')
        },
        props:['order'],
        methods:{
            close () {
                this.dialog = false
            },
        },
    }
</script>

<style>

</style>