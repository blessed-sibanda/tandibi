<template>
  <div class="places">
    <div class="place" :key="place.id" v-for="place in places">
      <p>{{ place.name | truncate(40) }}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      places: [
        {
          id: "1",
          locale: "en",
          name:
            "Restaurant 1 Very Very Very Very Very Very Very Ultimately Very Long name",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name: "Restaurant 2",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name:
            "Restaurant 1 Very Very Very Very Very Very Very Ultimately Very Long name",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name: "Restaurant 2",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name:
            "Restaurant 1 Very Very Very Very Very Very Very Ultimately Very Long name",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name: "Restaurant 2",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name:
            "Restaurant 1 Very Very Very Very Very Very Very Ultimately Very Long name",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
        {
          id: "1",
          locale: "en",
          name: "Restaurant 2",
          place_type: "restaurant",
          coordinates: { lng: 1, lat: 1 },
        },
      ],
    };
  },
};
</script>

<style scoped>
.places {
  @apply overflow-x-hidden overflow-y-scroll;
  height: 8em;
  min-height: 8em;
  max-height: 8em;
}

.place {
  @apply p-2 overflow-hidden;
  @apply cursor-pointer;
  min-height: 4em;
  height: 4em;
}

.place:hover {
  @apply bg-dark-600;
  @apply transition duration-100 ease-in;
}

@screen sm {
  .places {
    height: 300px;
    max-height: 300px;
    min-height: 300px;
  }

  .place {
    @apply ml-2;
  }
}
</style>
