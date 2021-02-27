const calendar = document.getElementById('slot_date');

flatpickr(calendar, {
  minDate: "today",
  dateFormat: "Y-m-d",
  mode: "multiple"
});
