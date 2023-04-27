# CheckoutController handles creating sessions for Stripe checkout.
class CheckoutController < ApplicationController
  before_action :find_product, only: %i[create]
  def create
    @session = Stripe::Checkout::Session.create(checkout_session_params)
    respond_to(&:js)
  end

  private

  def checkout_session_params
    {
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url
    }
  end

  def line_items
    [{
      price_data: {
        currency: 'usd',
        unit_amount: @product.price,
        product_data: {
          name: @product.name
        }
      },
      quantity: 1
    }]
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
