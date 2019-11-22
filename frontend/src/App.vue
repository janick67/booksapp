<template>
  <v-app :style="{background: $vuetify.theme.themes.light.background}">
    <Menu />

    <v-content>
      <router-view/>
    </v-content>
  </v-app>
</template>

<script>
import Menu from './components/Menu'

export default {
  name: 'App',
  components: {
    Menu
  },
  data () { return {} }
}
</script>
