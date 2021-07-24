<template>
  <div id="map">
    <l-map
      :zoom="zoom"
      :center="center"
      :options="mapOptions"
      @update:center="centerUpdate"
      @update:zoom="zoomUpdate"
    >
      <l-tile-layer :url="url" />
      <l-marker :lat-lng="center" />
    </l-map>
  </div>
</template>

<script>
import { latLng } from "leaflet";
import { LMap, LTileLayer, LMarker, LPopup, LTooltip } from "vue2-leaflet";
import "leaflet/dist/leaflet.css";
export default {
  name: "Map2",
  components: {
    LMap,
    LTileLayer,
    LMarker,
    LPopup,
    LTooltip,
  },
  data() {
    return {
      zoom: 15,
      lat: 0,
      lng: 0,
      url: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      mapOptions: {
        zoomSnap: 0.5,
      },
    };
  },
  computed: {
    center() {
      return latLng(this.lat, this.lng);
    },
  },
  methods: {
    zoomUpdate(zoom) {
      this.zoom = zoom;
    },
    centerUpdate(center) {
      this.$store.commit("SET_COORDINATES", [center.lng, center.lat]);
    },
  },
  mounted() {
    this.lat = this.$store.state.coordinates.lat;
    this.lng = this.$store.state.coordinates.lng;

    this.unsubscribe = this.$store.subscribe((mutation, state) => {
      if (mutation.type == "SET_COORDINATES") {
        this.lat = this.$store.state.coordinates.lat;
        this.lng = this.$store.state.coordinates.lng;
      } else if (mutation.type == "SET_SIGHT_SELECTED_PLACE") {
        this.lat = this.$store.state.sight.selectedPlace.coordinates.lat;
        this.lng = this.$store.state.sight.selectedPlace.coordinates.lng;
      }
    });
  },
  beforeDestroy() {
    this.unsubscribe();
  },
};
</script>

<style scoped>
#map {
  height: 150px;
}
@screen sm {
  #map {
    height: 300px;
  }
}
</style>
