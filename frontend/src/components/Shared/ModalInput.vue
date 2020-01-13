<template>
  <v-dialog v-model="dialog" max-width="250">
    <template v-slot:activator="{ on }">
      <v-btn color="primary" dark class="mb-5" v-on="on">{{btnText}}</v-btn>
    </template>
    <template>
      <v-card>
        <v-card-title>
          {{title}}
          <v-spacer></v-spacer>
        </v-card-title>
        <v-card-title>
          <template>
            <v-form ref="form"  lazy-validation>
              <v-text-field
                v-model="nameValue"
                :counter="25"
                label="Miejsce"
                required
              ></v-text-field>

              <v-text-field
                v-model="addressValue"
                :counter="25"
                label="Adres"
                required
              ></v-text-field>
              <v-text-field
                v-model="cityValue"
                :counter="25"
                label="Miasto"
                required
              ></v-text-field>

              <v-text-field 
                v-model="postalCodeValue" 
                v-mask="mask" 
                label="Kod pocztowy" 
                required>
              </v-text-field>

              
              <v-btn 
                color="success" 
                class="mr-4" 
                type="button"
                @click="validate">Wyślij</v-btn>
            </v-form>
          </template>
        </v-card-title>
      </v-card>
    </template>
  </v-dialog>
</template>

<script>
import { log } from "util";
import { mask } from "vue-the-mask";

export default {
  directives: {
    mask
  },

  data() {
    return {
      nameValue: "",
      addressValue: "",
      cityValue: "",
      postalCodeValue: "",
      dialog: false,
      search: "",
      renderComponent: true,
      mask: "##-###",
      value: ""
    };
  },
  props: ["title", "headers", "rows", "btnText"],
  methods: {
    submit() {
      this.$emit("submit", this.rows.filter(el => el.checkbox));
      this.close();
    },
    close() {
      this.rows.forEach(el => {
        delete el.checkbox;
      });
      this.forceRerender();
      this.dialog = false;
    },
    forceRerender() {
      // Remove my-component from the DOM
      this.renderComponent = false;

      this.$nextTick(() => {
        // Add the component back in
        this.renderComponent = true;
      });
    },
    validate() {
      const { nameValue, addressValue, cityValue, postalCodeValue } = this;

      fetch('/api/addresses', {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          'ad_name': nameValue,
          'ad_address1': addressValue,
          'ad_city': cityValue,
          'ad_postalCode': postalCodeValue
          })
      })
        .then((res) => {
          if (res.ok) this.dialog = false;
          else {
            alert('Error occured, please try again later');
            console.error(res);
          }
        });
    }
  }
};
</script>


<style>
</style>