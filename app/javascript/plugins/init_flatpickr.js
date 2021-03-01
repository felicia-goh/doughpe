const initFlatpickr = () => {
  const editForm = document.getElementById('edit-form');
  const slotDate = document.getElementById('slot_date');
  const productSlotDate = document.getElementById('product_slots_date');

  if (editForm) {
    flatpickr(slotDate, {
      minDate: "today",
      dateFormat: "Y-m-d",
      altInput: true,
      altFormat: "F j, Y",
      mode: "multiple",
      defaultDate: JSON.parse(editForm.dataset.selectedDates)
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
