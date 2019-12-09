<template>

<v-card
    class="mx-2"
  >
    <v-card-text class="text--primary">
<v-data-table
    :headers="headers"
    :items="desserts"
    hide-default-footer="true"
    class="elevation-1"
  >
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Książki</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>
        <v-spacer></v-spacer>
        <modalChoseBooks  @submit="modalSubmit"/>
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
import modalChoseBooks from './ChooseBooksModal'
  export default {
    data: () => ({
      dialog: false,
      headers: [
        {
          text: 'Tytuł',
          value: 'title',
        },
        { text: 'Autor', value: 'author' },
        { text: 'Wydawnictwo', value: 'print' },
        { text: 'Na magazynie', value: 'stocks' },
        { text: 'Cena', value: 'prize' },
        { text: 'Sztuk', value: 'count', sortable: false },
        { text: 'Akcja', value: 'action', sortable: false },
      ],
      desserts: [],
    }),
    components:{
      modalChoseBooks
    },

    computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'New Item' : 'Edit Item'
      },
    },

    watch: {
      dialog (val) {
        val || this.close()
      },
    },

    methods: {
      editItem (item) {
        this.editedIndex = this.desserts.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialog = true
      },
      modalSubmit(el){
          this.desserts = el;
      },
      deleteItem (item) {
        const index = this.desserts.indexOf(item)
        this.desserts.splice(index, 1)
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