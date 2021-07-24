const mutations = {
  SET_ERROR(state, error) {
    state.error = error;
  },

  RESET(state) {
    state.error = null;
    state.sight = { keyword: "", places: [], selectedPlace: null };
    state.coordinates = { lng: 0, lat: 0 };
  },

  SET_SIGHT_KEYWORD(state, kw) {
    state.sight.keyword = kw;
  },

  SET_COORDINATES(state, [lng, lat]) {
    state.coordinates.lng = lng;
    state.coordinates.lat = lat;
  },

  SET_SIGHT_PLACES(state, places) {
    state.sight.places = places;
  },

  SET_SIGHT_SELECTED_PLACE(state, place) {
    state.sight.selectedPlace = place;
  },
};

export default mutations;
