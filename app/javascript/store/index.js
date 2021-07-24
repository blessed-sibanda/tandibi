import Vue from "vue";
import Vuex from "vuex";
import actions from "./actions";
import mutations from "./mutations";

Vue.use(Vuex);

const isDev = process.env.NODE_ENV !== "production";

const store = new Vuex.Store({
  state: {
    error: null,
  },
  mutations,
  actions,
  getters: {
    hasError: (state) => (state.error ? true : false),
  },
  // raise an error is a state is unlawfully mutated
  strict: isDev,
});

store.commit("RESET");
export default store;
