// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import flatpickr from "flatpickr";
import jquery from 'jquery';
import "jquery-bar-rating";
window.$ = window.jquery = jquery;

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initCheckout } from '../plugins/init_checkout.js';
import { initEdit } from '../plugins/init_edit.js'
import { initStarRating } from '../plugins/init_star_rating.js';
import { initInsertLatest } from '../plugins/init_insert_latest.js';
import { initAutocomplete } from '../plugins/init_autocomplete.js';
import { initFlatpickr } from '../plugins/init_flatpickr.js';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initCheckout();
  initFlatpickr();
  initAutocomplete();
  initStarRating();
});
