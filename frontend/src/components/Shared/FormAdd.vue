<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-spacer></v-spacer>
        <v-btn color="primary" dark class="mb-2" v-on="on">Dodaj nowego</v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">Wprowadź dane</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="6" md="4">
                <v-text-field label="Login" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field label="Hasło"></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field label="E-mail" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="2">
                <v-select
                  :items="['1', '2', '3']"
                  label="Rola"
                  required
                ></v-select>
              </v-col>
              <v-col cols="12" sm="2">
                <v-select
                  :items="['1', '2', '3']"
                  label="StorID"
                  required
                ></v-select>
              </v-col>

              <v-col cols="12" sm="2">
                <v-select
                  :items="['1', '2']"
                  label="Status"
                  required
                ></v-select>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="back">Wróć</v-btn>
          <v-btn color="blue darken-1" text @click="nextForm" >Zapisz</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>

export default {
  data() {
    return {
    Login:'',
    Hasło:'',
    //E-mail:'',
    Rola:'',
    StorID:'',
    Status:''
    }
  },
  
   mounted(){
         
       
        },
        updated(){
          this.$store.dispatch('setAUDetails',{login: this.autoLogin})
        },
  computed: {
    autoLogin() {
      return this.Login
    },
   
  },
  created() {
    this.$store.dispatch('loadUsers');
     this.$store.dispatch('loadBooks');
  },
  methods: {
   back(){
this.$route.push('/admin/add');
   },
    nextForm(){
                this.$store.dispatch('sendUser')
            },
  }
};
</script>
