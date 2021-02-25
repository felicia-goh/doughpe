
const initCheckout = () => {

  document.querySelector('.disabled').disabled = true;
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
  total.innerText = calc.toFixed(2);

}

const updateCheckoutForm = (event) => {

  const placeholder = document.querySelector('.product-name-placeholder');
  placeholder.innerText = `${event.currentTarget.dataset.productName}`;

  const product = document.getElementById('product');
  product.innerHTML = `<input name="order[product_id]" type="hidden" value="${event.currentTarget.dataset.productId}" />`;

  const quantity = document.getElementById('quantity_field');
  const quantityHolder = document.getElementById('quantity_holder');
  quantityHolder.innerHTML = `<input id="product_price" type="hidden" value="${event.currentTarget.dataset.productPrice}" />`;
  quantity.classList.remove('d-none');

  const q = document.getElementById('order_quantity');
  const calc = q.value * event.currentTarget.dataset.productPrice;
  const total = document.getElementById('total');
  total.innerText = calc.toFixed(2) ;

  const slots_list = document.getElementById('order_slots_id');
  const slot_data = JSON.parse(event.currentTarget.dataset.slots);
  let options = `<option value></option>`;
  slot_data.forEach(slot => options = options.concat(`<option value="${slot.id}">${slot.date} Available: ${slot.available_quantity}</option>`));
  slots_list.innerHTML = options;

  document.getElementById('checkout').classList.remove('d-none');
  document.querySelector('.disabled').disabled = false;
  document.querySelector('.disabled').value = 'Order now!';


}

export { initCheckout }
