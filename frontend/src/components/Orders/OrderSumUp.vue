<template>

<v-card
    class="mx-2"
  >
  <v-card-title > Podsumowanie zamówienia </v-card-title>
    <v-card-text class="text--primary">
      <template>
        <v-form >
          <v-container>
            <v-row>
              <v-col>
                <v-text-field
                  v-model="netto"
                  label="Netto"
                  disabled="true"
                ></v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  v-model="gross"
                  label="Brutto"
                  disabled="true"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </template>
    </v-card-text>
  </v-card>
</template>

<script>
import ChooseBooks from './ChooseBooks'
    export default {
      data(){
        return {
          delivery:null,
          deliveryMethods:['Odbiór własny','Kurier']
        }
      }
    }
</script>


<style>

</style>