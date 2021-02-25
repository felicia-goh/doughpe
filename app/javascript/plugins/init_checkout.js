
const initCheckout = () => {
  const cards = document.querySelectorAll('.card');
  cards.forEach((card) => {
    card.addEventListener('click', updateCheckoutForm)
  })
  const quantity = document.querySelector('.order_quantity')
  quantity.addEventListener('click', updateQuantity)
  quantity.addEventListener('keyup', updateQuantity)

  const selfCollection = document.getElementById('order_delivery_method_self-collection')
  selfCollection.addEventListener('click', updateSelfCollection)
  const delivery = document.getElementById('order_delivery_method_delivery')
  delivery.addEventListener('click', updateDelivery)

}

const updateSelfCollection = (event) => {
  const delivery = document.getElementById('delivery_form')
  delivery.classList.add('d-none');
  // delivery.insertAdjacentHTML('beforeend', '<input name="order[delivery_address]" type="hidden" value="self-collection" />')
}

const updateDelivery = (event) => {
  const delivery = document.getElementById('delivery_form')
  delivery.classList.remove('d-none');
}

const updateQuantity = (event) => {
  const q = document.getElementById('order_quantity');
  const total = document.getElementById('total');
  const price = document.getElementById('product_price');
  const calc = q.value * price.value ;
  total.innerText = calc;

}

const updateCheckoutForm = (event) => {

  const placeholder = document.querySelector('.product-name-placeholder');
  const product = document.getElementById('product');
  const quantity = document.getElementById('quantity_field');
  const total = document.getElementById('total');
  const quantityHolder = document.getElementById('quantity_holder');
  const q = document.getElementById('order_quantity');
  const calc = q.value * event.currentTarget.dataset.productPrice;
  // For now
  // Add an h3 with the name of the item at the top
  placeholder.innerText = `${event.currentTarget.dataset.productName}`;
  product.innerHTML = `<input name="order[product_id]" type="hidden" value="${event.currentTarget.dataset.productId}" />`;
  quantityHolder.innerHTML = `<input id="product_price" type="hidden" value="${event.currentTarget.dataset.productPrice}" />`;
  quantity.classList.remove('d-none');
  total.innerText = calc.toFixed(2) ;

  const slots_list = document.getElementById('order_slots_id');
  const slot_data = JSON.parse(event.currentTarget.dataset.slots);
  console.dir(slot_data[0].date);
  // console.log(slots_list);
  // slot_data.forEach(slot => slots_list.insertAdjacentHTML('beforeend', `<option value="${slot.id}>${slot.date} Available: ${slot.available_quantity}</option>`));
  slots_list.insertAdjacentHTML('beforeend', `<option value="${slot_data[0].id}">${slot_data[0].date} Available: ${slot_data[0].available_quantity}</option>`);




}
  // If I am in the show page
  // Start the logic!

  // Whenever the user clicks on checkout
  // Send a form and render it fresh in the html

  // Whenever the user clicks on the delivery radio button
  // Modify the form

  // Whenever the user clicks on the pickup radio button
  // Restore the form



export { initCheckout }
