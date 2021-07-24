import Vue from "vue";
import Vuex from "vuex";
import actions from "./actions";
import mutations from "./mutations";

Vue.use(Vuex);

const isDev = process.env.NODE_ENV !== "production";

const store = new Vuex.Store({
  state: {
    error: null,
    sight: null,
    coordinates: { lat: 0, lng: 0 },
  },
  mutations,
  actions,
  getters: {
    hasError: (state) => (state.error ? true : false),
  },
  // raise an error is a state is unlawfully mutated
  strict: isDev,
});

function resetStore() {
  store.commit("RESET");
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      store.commit("SET_COORDINATES", [
        position.coords.longitude,
        position.coords.latitude,
      ]);
    });
  }
}

resetStore();
export default store;
