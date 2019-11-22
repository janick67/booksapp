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
      > Wydatki</v-btn></v-toolbar-title>

      <div class="flex-grow-1"></div>

       <v-btn
          v-if="userIsAuthenticated"
          active-class="notBackground"
          text
          elevation="4"
          @click="onLogout">
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
            Wydatki
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
    <!-- <div>
    <v-toolbar class="primary" dark>
      <v-toolbar-title>
        <v-btn class="primary" to="/">Wydatki</v-btn>
      </v-toolbar-title>

      <div class="flex-grow-1"></div>

      <v-toolbar-items>
        <v-btn
          class="primary"
          v-for="item in menuItems"
          :key="item.title"
          :to="item.link">
          <v-icon left dark>{{ item.icon }}</v-icon>
          {{ item.title }}

        </v-btn>

        <v-btn
          class="primary"
          v-if="userIsAuthenticated"
          @click="onLogout">
          <v-icon left dark>mdi-exit-to-app</v-icon>
          logout
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>
  </div> -->
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
        { icon: 'mdi-fountain', text: 'Wypróbuj', link: '/demo' },
        { icon: 'mdi-face', text: 'Zarejestruj', link: '/signup' },
        { icon: 'mdi-lock-open-variant', text: 'Zaloguj', link: '/signin' }
      ]
      if (this.userIsAuthenticated) {
        menuItems = [
          { icon: 'mdi-calculator', text: 'Podsumowanie', link: '/summary' },
          { icon: 'mdi-calendar', text: 'Kalendarz', link: '/calendary' },
          { icon: 'mdi-bank', text: 'Konta', link: '/accounts' },
          { icon: 'mdi-bank-transfer', text: 'Transakcje', link: '/deals' },
          { icon: 'mdi-cash-refund', text: 'Dłużnicy', link: '/debtors' },
          { icon: 'mdi-bank-transfer-out', text: 'Moje długi', link: '/debt' },
          { icon: 'mdi-folder-open', text: 'Kategorie', link: '/categories' },
          { icon: 'mdi-chart-bar', text: 'Wykresy', link: '/charts' },
          { icon: 'mdi-account', text: 'Profil', link: '/profile' },
          { icon: 'mdi-settings', text: 'Ustawienia', link: '/settings' },
          { icon: 'mdi-exit-to-app', text: 'Wyloguj', link: '/logout' }
        ]
      }
      return menuItems
    },
    userIsAuthenticated () {
      return this.$store.getters.user !== null && this.$store.getters.user !== undefined
    }
  },
  methods: {
    onLogout () {
      this.$store.dispatch('logout')
    }
  }
}
</script>

<style  scoped>
.notBackground::before{
  display:none;
}
</style>
