import Vue from "vue";
import SightPoster from "../components/SightPoster";
import { truncate } from "../lib/filters";
import store from "../store";

import { Icon } from "leaflet";

delete Icon.Default.prototype._getIconUrl;

Icon.Default.mergeOptions({
  iconRetinaUrl: require("leaflet/dist/images/marker-icon-2x.png"),
  iconUrl: require("leaflet/dist/images/marker-icon.png"),
  shadowUrl: require("leaflet/dist/images/marker-shadow.png"),
});

Vue.filter("truncate", truncate);

function renderSight() {
  const sightPoster = new Vue({
    store,
    render: (h) => h(SightPoster),
  }).$mount();

  document.querySelector(".js-sight-poster").appendChild(sightPoster.$el);
}

document.addEventListener("turbolinks:load", () => {
  if (document.querySelector(".js-sight-poster")) {
    renderSight();
  }
});
