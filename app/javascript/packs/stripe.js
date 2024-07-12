// app/javascript/packs/stripe.js
document.addEventListener("turbolinks:load", function() {
    var stripe = Stripe('<%= Rails.application.credentials.dig(:stripe, :publishable_key) %>');
    var elements = stripe.elements();
    var card = elements.create('card');
    card.mount('#card-element');
  
    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();
  
      stripe.createToken(card).then(function(result) {
        if (result.error) {
          // Display error.message in your UI
          var errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          // Send the token to your server
          var hiddenInput = document.createElement('input');
          hiddenInput.setAttribute('type', 'hidden');
          hiddenInput.setAttribute('name', 'stripeToken');
          hiddenInput.setAttribute('value', result.token.id);
          form.appendChild(hiddenInput);
  
          // Submit the form
          form.submit();
        }
      });
    });
  });
  