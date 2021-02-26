const clearResults = (results) => {
  while (results.hasChildNodes()) {
    results.removeChild(results.firstChild);
  }
};

const createList = (data) => {
  data.suggestions.forEach((result) => {
    if (result.username) {
      results.insertAdjacentHTML("beforeend", `<li class="search-result-item">${result.username}</li>`);
    } else {
      results.insertAdjacentHTML("beforeend", `<li class="search-result-item">${result.name}</li>`);
    }
  });
  document.querySelectorAll('li').forEach((li) => {
    li.addEventListener('click', fillInSearchForm)
  })
};

const fillInSearchForm = (event) => {
  let value = event.currentTarget.innerText;
  const searchTerm = document.querySelector('#search_query')
  searchTerm.value = value;
  const results = document.querySelector('#results');
  clearResults(results);
}

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
