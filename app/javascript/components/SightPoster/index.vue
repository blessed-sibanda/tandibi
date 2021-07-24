<template>
  <div id="sight">
    <place-finder />
    <div class="flex-col-reverse sm:flex-row">
      <div class="sm:w-2/3">
        <Map />
      </div>
      <div class="sm:w-1/3">
        <place-list />
      </div>
    </div>
  </div>
</template>

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
