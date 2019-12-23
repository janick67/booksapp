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
                  :disabled=true
                ></v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  v-model="gross"
                  label="Brutto"
                  :disabled=true
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
    export default {
      data(){
        return {
          netto:144,
          gross:412
        }
      }
    }
</script>


<style>

</style>