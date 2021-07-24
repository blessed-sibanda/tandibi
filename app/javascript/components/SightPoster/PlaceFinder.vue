<template>
  <div class="sight-place-finder">
    <input
      type="text"
      @keyup="findPlace"
      v-model="keyword"
      placeholder="Find place..."
    />
  </div>
</template>

<script>
import debounce from "lodash/debounce";
export default {
  computed: {
    keyword: {
      get() {
        return this.$store.state.sight.keyword;
      },
      set(value) {
        this.$store.commit("SET_SIGHT_KEYWORD", value);
      },
    },
  },
  methods: {
    findPlace: debounce(function() {
      this.$store.dispatch("findPlace");
    }, 300),
  },
};
</script>

<style scoped>
input {
  @apply bg-dark-700 text-xl;
  @apply mb-2;
  width: 100%;
}
</style>
