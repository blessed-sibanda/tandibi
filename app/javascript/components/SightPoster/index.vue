<template> </template>

<script>
import Map from "./Map.vue";
import PlaceFinder from "./PlaceFinder.vue";
import PlaceList from "./PlaceList.vue";
export default {
  components: { Map, PlaceFinder, PlaceList },
};
</script>

<style scoped>
.spaced {
  @apply mt-1 mb-1;
  font-size: 0;
}
</style>
