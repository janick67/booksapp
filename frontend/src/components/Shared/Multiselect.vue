<template>
    <div class="mb-3">
        <label
        class="v-label--active theme--light"
        >
            {{title}}
        </label>
        <multiselect
            v-model="value"
            tag-placeholder="Dodaj nowy element"
            placeholder="Wybierz..."
            label="name"
            track-by="code"
            :options="options"
            :multiple="multiselect"
            :taggable="true"
            @input="input"
            @tag="addTag">
        </multiselect>
    </div>
</template>

<script>
import Multiselect from 'vue-multiselect'

export default {
  components: {
    Multiselect
  },
  data () {
    return {
      value: []
    }
  },
  props: [
    'options',
    'title',
    'multiselect'
  ],
  methods: {
    addTag (newTag) {
      const tag = {
        name: newTag,
        code: newTag
      }
      this.options.push(tag)
      if (this.multiselect) {
        this.value.push(tag)
      } else {
        this.value = tag
      }
    },
    input () {
      const arr = []
      if (this.multiselect) {
        this.value.forEach(el => {
          arr.push(el.code)
        })
      } else {
        arr.push(this.value.code)
      }

      this.$emit('input', arr)
    }
  }
}
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
