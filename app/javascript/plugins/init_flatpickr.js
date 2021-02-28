const initFlatpickr = () => {
  const editForm = document.getElementById('edit-form');
  const slotDate = document.getElementById('slot_date');

  if (editForm) {
    flatpickr(slotDate, {
      minDate: "today",
      dateFormat: "Y-m-d",
      altInput: true,
      altFormat: "F j, Y",
      mode: "multiple"
      // default: editForm.dataset.selectedDates
    });
  } else if (slotDate) {
    flatpickr(slotDate, {
      minDate: "today",
      dateFormat: "Y-m-d",
      altInput: true,
      altFormat: "F j, Y",
      mode: "multiple",
    });
  }
}

export { initFlatpickr }
