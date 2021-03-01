  const initInsertLatest = () => {
    const delivered = document.querySelector('.delivered');
    const undelivered = document.querySelector('.undelivered');

    if (undelivered) {
      delivered.insertAdjacentHTML("afterend",
      `<% if order.slot.product.photo.attached? %>
      <%= cl_image_tag order.slot.product.photo.key, class: "img" %>
      <% else %>
      <img class="img" src="https://www.biggerbolderbaking.com/wp-content/uploads/2018/03/No-Bake-Chocolate-Chip-Cookies1.jpg" alt="product image">
      <% end %>
      <div class="card-product-info-container d-flex justify-content-between align-items-center">
        <div class="card-product-infos">
          <h2><%= "#{order.quantity}x #{order.slot.product.name} from #{order.slot.product.user.username}"%></h2>
          <p>$<%= number_with_precision(order.subtotal, precision: 2) %></p>
        </div>
      <div>
      <%= link_to 'Order Again', baker_path(order.slot.product.user.username), class: 'btn btn-primary' %>
      <% if order.review.nil? %>
      <%= link_to 'Review Baker',new_order_review_path(order), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class: 'btn btn-primary'}%>
      <div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
      <div class="modal-content"></div>
      </div>
      </div>
      <% else %>
      <% order.review.rating.times do  %>
      <i class="fa fa-star checked" aria-hidden="true"></i>
      <% end %>
      </div>`
     );
    }
    // if (undelivered){
    //   undelivered.insertAdjacentHTML("beforeend",
    //   `<% if order.slot.product.photo.attached? %>
    //   <%= cl_image_tag order.slot.product.photo.key, class: "img" %>
    //   <% else %>
    //   <img class="img" src="https://www.biggerbolderbaking.com/wp-content/uploads/2018/03/No-Bake-Chocolate-Chip-Cookies1.jpg" alt="product image">
    //   <% end %>
    //   <div class="card-product-info-container d-flex justify-content-between align-items-center">
    //   <div class="card-product-infos">
    //   <h2><%= "#{order.quantity}x #{order.slot.product.name} from #{order.slot.product.user.username}"%></h2>
    //   <p>$<%= number_with_precision(order.subtotal, precision: 2) %></p>
    //   </div>
    //   <span class="badge badge-light">not delivered</span>
    //   </div>
    //   </div>`);

    // }
  }

  export { initInsertLatest };
