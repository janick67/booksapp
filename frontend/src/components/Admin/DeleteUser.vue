<template>
<v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-icon
                small
                v-on="on"
            >
                mdi-delete
            </v-icon>
          </template>
      <v-card>
        <v-card-title class="headline">Jesteś pewien, że chcesz usunąć użytkownika?</v-card-title>

        <v-card-text>
        Tej operacji nie mozna cofnąć!
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="blue darken-1"
            text
            @click="back"
          >
            Anuluj
          </v-btn>

          <v-btn
            color="blue darken-1"
            text
            @click="send"
          >
            Zatwierdź
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
export default {
  data () {
    return {
      dialog: false
    }
  },
  created () {
    this.$store.dispatch('loadUsers')
  },
  computed: {
    users () {
      return this.$store.getters.users
    }
  },
  props: ['user'],
  methods: {
    close () {
      this.dialog = false
    },
    back () {
      this.dialog = false
    },
    send () {
   const userID  = this.user.us_ID;
 
    this.$store.dispatch('deleteUser',{  userID  }); 
   
    this.dialog = false;
     this.$emit('rerenderUser')
   }
    },
    }
</script>

<style>

</style>