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
      zoom: 13,
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
      this.lat = center.lat;
      this.lng = center.lng;
    },
    success(position) {
      this.lat = position.coords.latitude;
      this.lng = position.coords.longitude;
    },
  },
  mounted() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.success);
    }
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
