
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
}

const updateDelivery = (event) => {
  const delivery = document.getElementById('delivery_form')
  delivery.classList.remove('d-none');
}

const updateQuantity = (event) => {
  const q = document.getElementById('order_quantity');
  const total = document.getElementById('total');
  const calc = q.value * 1 ;

}

const updateCheckoutForm = (event) => {

  const placeholder = document.querySelector('.product-name-placeholder');
  const product = document.getElementById('order_quantity');
  const quantity = document.getElementById('quantity_field');
  // For now
  // Add an h3 with the name of the item at the top
  placeholder.innerText = `${event.currentTarget.dataset.productName}`;
  product.insertAdjacentHTML('afterend', `<input name="order[product_id]" type="hidden" value="${event.currentTarget.dataset.productId}" />`)
  quantity.insertAdjacentHTML('beforeend', `<input id="product_price" type="hidden" value="${event.currentTarget.dataset.productPrice}" />`)
  quantity.classList.remove('d-none');

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
