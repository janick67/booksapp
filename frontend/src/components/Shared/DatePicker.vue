<template>
    <v-menu
        :close-on-content-click="false"
        transition="scale-transition"
        offset-y
        max-width="290px"
        min-width="290px"
        >
        <template v-slot:activator="{ on }">
            <v-text-field
            v-model="dateFormatted"
            readonly
            label="Data"
            required
            @blur="date = parseDate(dateFormatted)"
            v-on="on"
            ></v-text-field>
        </template>
        <v-date-picker v-model="date" no-title @input="menu1 = false"></v-date-picker>
        </v-menu>
</template>

<script>
export default {

  data: vm => ({
    date: new Date().toISOString().substr(0, 10),
    dateFormatted: vm.formatDate(new Date().toISOString().substr(0, 10))
  }),
  created () {
    this.$emit('input', this.dateFormatted)
  },
  computed: {
    computedDateFormatted () {
      return this.formatDate(this.date)
    }
  },
  watch: {
    date (val) {
      this.dateFormatted = this.formatDate(this.date)
      this.$emit('input', this.dateFormatted)
    }
  },

  methods: {
    formatDate (date) {
      if (!date) return null
      const [year, month, day] = date.split('-')
      return `${day}.${month}.${year}`
    },
    parseDate (date) {
      if (!date) return null

      const [day, month, year] = date.split('.')
      return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`
    }
  }
}
</script>
