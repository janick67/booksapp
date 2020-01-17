<template>
  <v-card class="mx-2">
    <v-card-title>  Użytkownicy</v-card-title>
    <v-card-text class="text--primary">
      <v-data-table
        v-if="renderComponent"
        :headers="headers"
        :items="users"
        :hide-default-footer="true"
        class="elevation-1"
      >
        <template v-slot:top>
          <v-toolbar flat color="white">
            <v-toolbar-title>Użytkownicy w systemie</v-toolbar-title>
            <v-divider class="mx-4" inset vertical></v-divider>
            <v-spacer></v-spacer>
           
         
            <FormAdd
              @rerenderUser="forceRerender"
              title="Wybierz ksiażki"
              btnText="Dodaj pozycje"
              :headers="headers"
              :rows="users"
            />
          </v-toolbar>
        </template>
        <template v-slot:item.count="{ item }">
          <v-text-field v-model="item.count"></v-text-field>
        </template>
        <template v-slot:item.action="{ item }">
          <v-icon small @click="deleteItem(item)">
            mdi-delete
          </v-icon>
        </template>
      </v-data-table>
    </v-card-text>
  </v-card>
</template>

<script>
import FormAdd from '../Shared/FormAdd';
export default {
  data: () => ({
    renderComponent: true,
    dialog: false,
    headers: [
      {
        text: 'ID',
        value: 'us_ID'
      },
      { text: 'Login', value: 'us_login' },
      { text: 'E-mail', value: 'us_email' },
      { text: 'RoleID', value: 'us_roleID' },
      { text: 'StorID', value: 'us_storeID' },
      { text: 'Akcja', value: 'action', sortable: false }
    ],
    
   
  }),
  components: {
    FormAdd
  },
  computed: {
    users() {
      return this.$store.getters.users;
    },
    books() {
      return this.$store.getters.books;
    }
  },
  created() {
    this.$store.dispatch('loadUsers');
     this.$store.dispatch('loadBooks');
  },
  methods: {
    deleteItem(item) {
      const index = this.users.indexOf(item);
      this.users.splice(index, 1);
      
    },
    forceRerender() {
      // Remove my-component from the DOM
      this.renderComponent = false;

      this.$nextTick(() => {
        // Add the component back in
        this.renderComponent = true;
      });
    }
  }
};
</script>

<style></style>
