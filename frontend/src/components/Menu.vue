<template>
<div>
    <v-app-bar
      color="primary"
      dark
    >
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>

      <v-toolbar-title><v-btn
       to="/"
       active-class="notBackground"
       text
      > Booksapp</v-btn></v-toolbar-title>

      <div class="flex-grow-1"></div>

       <v-btn
          v-if="userIsAuthenticated"
          active-class="notBackground"
          text
          elevation="4"
          to="/logout">
          <v-icon left dark>mdi-exit-to-app</v-icon>
          Wyloguj
        </v-btn>
        <v-btn
        v-else
        active-class="notBackground"
        text
        elevation="4"
        to="/signin">
          <v-icon left dark>mdi-lock-open-variant</v-icon>
          Zaloguj
        </v-btn>

    </v-app-bar>

     <v-navigation-drawer
      v-model="drawer"
      app
      clipped
    >
         <v-list-item
         link
         to="/"
          >
        <v-list-item-content>
          <v-list-item-title class="title">
            Booksapp
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>
      <v-list
        dense
      >
        <template v-for="(item, i) in menuItems">
          <v-list-item
            :key="i"
            link
            :to=item.link
          >
            <v-list-item-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                {{ item.text }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
      </v-list>
    </v-navigation-drawer>

  </div>

</template>

<script>
export default {
  data () {
    return {
      sideNav: false,
      drawer: null
    }
  },
  computed: {
    menuItems () {
      let menuItems = [
        { icon: 'mdi-lock-open-variant', text: 'Zaloguj', link: '/signin' }
      ]
      if (this.userIsAuthenticated) {
        if (this.user.roleID === 1) { // role: 1 - admin, 2 - centrala, 3 - filia
          menuItems = [
            { icon: 'mdi-bank-transfer', text: 'Dodaj zamówienie', link: '/orders/add' },
            { icon: 'mdi-bank-transfer', text: 'Lista zamówień', link: '/orders/list' },
            { icon: 'mdi-bank-transfer', text: 'Lista użytkowników', link: '/users/add' },
            { icon: 'mdi-bank-transfer', text: 'Magazyn', link: '/warehouse' },
            { icon: 'mdi-exit-to-app', text: 'Wyloguj', link: '/logout' }
          ]
        } else if (this.user.role === 2) { // role: 1 - admin, 2 - centrala, 3 - filia
          menuItems = [
            { icon: 'mdi-bank-transfer', text: 'Dodaj zamówienie', link: '/orders/add' },
            { icon: 'mdi-bank-transfer', text: 'Lista zamówień', link: '/orders/list' },
            { icon: 'mdi-bank-transfer', text: 'Magazyn', link: '/warehouse' },
            { icon: 'mdi-bank-transfer', text: 'Lista użytkowników', link: '/users/add' },
            { icon: 'mdi-exit-to-app', text: 'Wyloguj', link: '/logout' }
          ]
        } else {
          menuItems = [
            { icon: 'mdi-bank-transfer', text: 'Dodaj zamówienie', link: '/orders/add' },
            { icon: 'mdi-bank-transfer', text: 'Lista zamówień', link: '/orders/list' },
            { icon: 'mdi-exit-to-app', text: 'Wyloguj', link: '/logout' }
          ]
        }
      }
      return menuItems
    },
    userIsAuthenticated () {
      return this.$store.getters.user !== null && this.$store.getters.user !== undefined
    },
    user () {
      return this.$store.getters.user
    }
  }
}
</script>

<style  scoped>
.notBackground::before{
  display:none;
}
</style>
