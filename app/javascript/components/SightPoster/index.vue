<template>
  <div id="sight">
    <input
      type="hidden"
      name="post[sight_place_id]"
      :value="selectedPlace.id"
    />
    <place-finder />
    <div class="block sm:flex">
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
  computed: {
    selectedPlace() {
      return this.$store.state.sight.selectedPlace || {};
    },
  },
};
</script>

<style scoped>
.spaced {
  @apply mt-1 mb-1;
  font-size: 0;
}
</style>
