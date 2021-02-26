const clearResults = (results) => {
  while (results.hasChildNodes()) {
    results.removeChild(results.firstChild);
  }
};

const createList = (data, results) => {
  data.words.forEach((word) => {
    results.insertAdjacentHTML("beforeend", `<li>${word}</li>`);
  });
};

const autocomplete = () => {
  const searchTerm = document.querySelector('input').value;
  const results = document.querySelector('#results');
  clearResults(results);
  fetch(url(searchTerm))
    .then(response => response.json())
    .then(data => createList(data, results))
    .catch(err => console.log(err));
};

const inputCont = document.querySelector('#container');

const autocomplete = () => inputCont.addEventListener('keyup', autocomplete);

export default autocomplete;
