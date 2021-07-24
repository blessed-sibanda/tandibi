function handleError(commit, error) {
  const message = error.message || error.info.error_description;
  commit("SET_ERROR", message);
}

const actions = {};

export default actions;
