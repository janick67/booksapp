<template>
  <div>
    <h1>Dodaj użytkownika</h1>
    <div v-if="!sale && !internal"></div>
    <div v-else>
      <UserAdd class="ma-2" />
    </div>
  </div>
</template>
<script>

import UserAdd from '@/components/Admin/UserAdd';

export default {
  components: {
    UserAdd
  },
  data() {
    return {
      sale: true,
      internal: false,
      books: []
    };
  },
  methods: {
    makeSale() {
      this.sale = true;
      this.internal = false;
    },
    makeInternal() {
      this.sale = false;
      this.internal = true;
    }
  }
};
</script>

<style></style>
