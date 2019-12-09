<template>
        <v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">New Item</v-btn>
          </template>
              <template>
                <v-card>
                  <v-card-title>
                    Wybierz książkę
                    <v-spacer></v-spacer>
                    <v-text-field
                      v-model="search"
                      append-icon="mdi-search"
                      label="Search"
                      single-line
                      hide-details
                    ></v-text-field>
                    <v-btn small color="primary" @click='submit'>Wybierz</v-btn>
                  </v-card-title>
                  <v-data-table
                    :headers="headers"
                    :items="desserts"
                    :search="search"
                  >
                  <template v-slot:item.checkbox="{ item }">
                    <v-checkbox v-model="item.checkbox"></v-checkbox>
                  </template>
                </v-data-table>
                </v-card>
              </template>
        </v-dialog>

</template>

<script>
import { log } from 'util';
  export default {
    data () {
      return {
        dialog: false,
        search: '',
        headers: [
          {
            text: '',
            align: 'left',
            sortable: false,
            value: 'checkbox'
          },
          { text: 'Tytuł', value: 'title' },
          { text: 'Autor', value: 'author' },
          { text: 'Wydawnictwo', value: 'print' },
          { text: 'Na magazynie', value: 'stocks' },
        ],
        desserts: [],
      }
    },
    created() {
      this.init()
    },
    methods:{
      init() {
        this.desserts = this.$store.getters.books;
      },
      submit() {
        this.close()
        this.$emit('submit',this.desserts.filter(el => el.checkbox))
      },
      close () {
        this.dialog = false
        setTimeout(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        }, 300)
      },
      save () {
        if (this.editedIndex > -1) {
          Object.assign(this.desserts[this.editedIndex], this.editedItem)
        } else {
          this.desserts.push(this.editedItem)
        }
        this.close()
      },
    },
  }
</script>


<style>

</style>