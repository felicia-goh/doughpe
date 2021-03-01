
const initCheckout = () => {

  if (document.querySelector('.shop') != null) {

    document.getElementById('add_to_cart').disabled = true;

    const cards = document.querySelectorAll('.card');
    cards.forEach((card) => {
      card.addEventListener('click', updateCheckoutForm)
    })

    const quantity = document.querySelector('.order_quantity')
    quantity.addEventListener('click', updateQuantity);
    quantity.addEventListener('keyup', updateQuantity);
    quantity.addEventListener('change', updateQuantity);

    const selfCollection = document.getElementById('order_delivery_method_self-collection')
    selfCollection.addEventListener('click', updateSelfCollection)
    const delivery = document.getElementById('order_delivery_method_delivery')
    delivery.addEventListener('click', updateDelivery)

    const slots = document.getElementById('order_slots_id');
    slots.addEventListener('change', updateSlotQuantity);

    const submitButton = document.querySelector('.disabled')
    submitButton.addEventListener('click', updateBasket);

  }
}

const updateSlotQuantity = (event) => {
  const quantityField = document.getElementById('order_quantity');
  const quantity = event.currentTarget.innerText.split(': ')[1];
  let options = `<option value></option>`;
  for (let i = 1; i < (parseInt(quantity) + 1); i++ ) {
    options = options.concat(`<option value="${i}">${i}</option>`);
  }
  quantityField.innerHTML = options;
}

const updateSelfCollection = (event) => {
  const delivery = document.getElementById('delivery_form')
  delivery.classList.add('d-none');
  document.getElementById('order_delivery_address').value = 'self-collection';
}

const updateDelivery = (event) => {
  const delivery = document.getElementById('delivery_form')
  delivery.classList.remove('d-none');
}

const updateQuantity = (event) => {
  const q = document.getElementById('order_quantity');
  const subtotal = document.getElementById('sub-total');
  const price = document.getElementById('product_price');
  const calc = q.value * price.value ;
  subtotal.innerText = calc.toFixed(2);

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
  const subtotal = document.getElementById('sub-total');
  subtotal.innerText = calc.toFixed(2) ;

  const slots_list = document.getElementById('order_slots_id');
  const slot_data = JSON.parse(event.currentTarget.dataset.slots);
  let options = `<option value></option>`;
  slot_data.forEach(slot => options = options.concat(`<option value="${slot.id}">${slot.date} Available: ${slot.available_quantity}</option>`));
  slots_list.innerHTML = options;

  document.getElementById('checkout').classList.remove('d-none');
  document.getElementById('add_to_cart').disabled = false;
  document.getElementById('add_to_cart').classList.remove('disabled')
  document.getElementById('add_to_cart').value = 'Order now!';
}


const updateBasket = (event) => {
  event.preventDefault();
  let buyNowButton = document.querySelector('.buynow')
  buyNowButton.classList.remove('d-none');

  let slotId = document.querySelector('[name="order[slots][id]"]').value
  let deliveryDate = document.getElementById('order_slots_id').innerText.split(' ')[0];
  let basket = document.querySelector('.basket');
  let timeRadio = document.querySelectorAll('[name="order[time_period]"]')
  let timePeriod = getTimePeriod(timeRadio)
  let productName = document.querySelector('.product-name-placeholder').innerText
  let itemQuantity = document.getElementById('order_quantity');
  let deliveryMethodRadio = document.querySelectorAll('[name="order[delivery_method]"]');
  let deliveryMethod = getDeliveryMethod(deliveryMethodRadio)
  let deliveryAddress = document.getElementById('order_delivery_address').value;

  $.ajax({
    url: '/add_to_basket',
    type: 'post',
    data: { order: { slot_id: slotId, time_period: timePeriod, quantity: parseInt(itemQuantity.value), delivery_method: deliveryMethod, delivery_address: deliveryAddress }},
    success: function (data) { },
    error: function (data) { console.log("didnt work")},
    complete: function (data) { handleAJAXPost(data) }
  })
  // basket.insertAdjacentHTML('afterbegin', `<div class="d-flex justify-content-between"><h4> ${productName} </h4><h4>x${itemQuantity.value}</h4></div><p>Date: ${deliveryDate} | ${timePeriod}</p><p>${deliveryMethod}</p>`)
  // basket.insertAdjacentHTML('afterbegin', `<input type="hidden" name="orders[][order][slot_id]" value="${slotId}">`);
  // basket.insertAdjacentHTML('afterbegin', `<input type="hidden" name="orders[][order][time_period]" value="${timePeriod}">`);
  // basket.insertAdjacentHTML('afterbegin', `<input type="hidden" name="orders[][order][quantity]" value="${itemQuantity.value}">`);
  // basket.insertAdjacentHTML('afterbegin', `<input type="hidden" name="orders[][order][delivery_method]" value="${deliveryMethod}">`);
  // basket.insertAdjacentHTML('afterbegin', `<input type="hidden" name="orders[][order][delivery_address]" value="${deliveryAddress}">`);

  const total = document.getElementById('total')
}

const handleAJAXPost = (data) => {
  if (data.responseJSON != 'undefined') {
    console.log( data.responseJSON.order.id )
    let deliveryDate = document.getElementById('order_slots_id').innerText.split(' ')[0];
    let basket = document.querySelector('.basket');
    let timeRadio = document.querySelectorAll('[name="order[time_period]"]')
    let timePeriod = getTimePeriod(timeRadio)
    let productName = document.querySelector('.product-name-placeholder').innerText
    let itemQuantity = document.getElementById('order_quantity');
    let deliveryMethodRadio = document.querySelectorAll('[name="order[delivery_method]"]');
    let deliveryMethod = getDeliveryMethod(deliveryMethodRadio)
    let subtotal = document.getElementById('sub-total')
    basket.insertAdjacentHTML('afterbegin', `<ul class="list-group mb-3 z-depth-1 text-dark">
            <li class="list-group-item d-flex justify-content-between lh-condensed">
              <div>
                <h6 class="my-0">${productName}</h6>
                <small class="text-muted">@${window.location.pathname.split('/')[2]}</small><br>
                <small class="text-muted">${deliveryDate} | ${timePeriod}</small><br>
                <small class="text-muted">${itemQuantity.value}x</small>
              </div>
              <span class="text-muted">$${subtotal.innerText}</span>
            </li>
          </ul>`)
    let total = document.getElementById('total')
    total.innerText = parseFloat(total.innerText) + parseFloat(subtotal.innerText);
    createCheckoutLink(data.responseJSON.order.id)

  }
}

const createCheckoutLink = (orderId) => {
  if ( document.getElementById('checkoutButton') != null ) {
    document.getElementById('checkoutButton').href = `/orders/${orderId}/edit`
  }

}

const getTimePeriod = (timeRadio) => {
  for (let i = 0; i < timeRadio.length; i++) {
    if (timeRadio[i].checked) {
      let timePeriod = ''
      timePeriod = timeRadio[i].value
      return timePeriod;
    }
  }
}

const getDeliveryMethod = (deliveryMethodRadio) => {
  for (let i = 0; i < deliveryMethodRadio.length; i++) {
    if (deliveryMethodRadio[i].checked) {
      let deliveryMethod = ''
      deliveryMethod = deliveryMethodRadio[i].value
      return deliveryMethod;
    }
  }
}

export { initCheckout }
