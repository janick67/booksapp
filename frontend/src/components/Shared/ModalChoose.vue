<template>
        <v-dialog v-model="dialog" max-width="700">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">{{btnText}}</v-btn>
          </template>
              <template>
                <v-card>
                  <v-card-title>
                    {{title}}
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
                    v-if="renderComponent"
                    :headers="headers"
                    :items="rows"
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
        renderComponent: true,
      }
    },
    props:['title','headers','rows','btnText'],
    methods:{
      submit() {
        this.$emit('submit',this.rows.filter(el => el.checkbox))
        this.close()
      },
      close () {
        this.rows.forEach(el => {
        delete el.checkbox;        
        });
        this.forceRerender()
        this.dialog = false
      },
      forceRerender() {
        // Remove my-component from the DOM
        this.renderComponent = false;
        
        this.$nextTick(() => {
          // Add the component back in
          this.renderComponent = true;
        });
      }
    },
  }
</script>


<style>

</style>