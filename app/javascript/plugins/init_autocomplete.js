const clearResults = (results) => {
  while (results.hasChildNodes()) {
    results.removeChild(results.firstChild);
  }
};

const createList = (data) => {
  data.suggestions.forEach((result) => {
    if (result.username) {
      results.insertAdjacentHTML("beforeend", `<li>${result.username}</li>`);
    } else {
      results.insertAdjacentHTML("beforeend", `<li>${result.name}</li>`);
    }
  });
  // document.querySelectorAll('li').forEach((li) => {
  //   li.addEventListener('click', updateFormValue)
  // })
};

const autocomplete = () => {
  const searchTerm = document.querySelector('#search_query').value;
  console.log(searchTerm);
  const results = document.querySelector('#results');
  clearResults(results);
  fetch(`/autocomplete.json?query=${searchTerm}`)
    .then(response => response.json())
    .then(data => createList(data))
    .catch(err => console.log(err));
};

const initAutocomplete = () => {
  const inputCont = document.querySelector('.input-cont');
  if (inputCont) {
    inputCont.addEventListener('keyup', autocomplete);
  }
}

export { initAutocomplete };
