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
                <v-text-field label="Login" v-model="loginValue" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                
                <v-text-field label="Hasło" v-model="passValue"></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field label="E-mail" required v-model="emailValue"></v-text-field>
              </v-col>
              <v-col cols="12" sm="2">
                <v-select
                v-model="roleValue"
                  :items="['1', '2', '3']"
                  label="Rola"
                  required
                ></v-select>
              </v-col>
              <v-col cols="12" sm="2">
                <v-select
                v-model="storeValue"
                  :items="storeIdList"
                  label="StorID"
                  required
                ></v-select>
              </v-col>

            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="back">Wróć</v-btn>
          <v-btn color="blue darken-1" text @click="sendUser" >Zapisz</v-btn
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
       dialog: false,
    loginValue:'',
    passValue:'',
    emailValue:'',
    roleValue:'',
    storeValue:''
   
    }
  },
  
  
  computed: {
     store() {
      return this.$store.getters.store;
    },

    storeIdList () {
      let tab = []
        this.store.forEach(el=>{
          tab.push(el.shortName)
          })
      return tab
},
   
  },
  created() {
    this.$store.dispatch('loadUsers');
     this.$store.dispatch('loadStore');
  },
  methods: {

    back(){
      this.dialog=false;
      },
   sendUser(){
    
    const { loginValue, emailValue, passValue, roleValue, storeValue } = this;
    let store = this.store.find(el=>{
      return el.shortName == storeValue
      })
  
    console.log('form add console',{ loginValue, emailValue, passValue, roleValue, storeValue:store.id })
    this.$store.dispatch('sendUser',{ loginValue, emailValue, passValue, roleValue, storeValue:store.id });
    this.dialog = false;
    this.$emit('rerenderUser')
   }}}

</script>
