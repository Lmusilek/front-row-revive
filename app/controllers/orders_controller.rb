class OrdersController < ApplicationController
  def payment
    event = Event.find(params[:event_id])
    order = Order.create!(event: event, event_sku: event.sku, amount: event.price, state: 'paid', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: event.sku,
        images: [event.photo],
        amount: event.price_cents,
        currency: event.currency,
        quantity: 1
      }],
      success_url: "https://www.frontrowgigs.com/orders/#{order.id}",
      cancel_url: "https://www.frontrowgigs.com/events/#{event.id}"

    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def deposit
    amount_no_cents = (params[:amount].to_i) * 100
    amount_cents = params[:amount]
    event = Event.find(params[:event_id])
    order = Order.create!(event: event, event_sku: event.sku, amount: amount_cents, state: 'paid', user: current_user)
    test_order =  Order.where(event_id: event.id).count
    test_order += amount_cents.to_i

    customer = Stripe::Customer.create({
      description: 'My First Test Customer (created for API docs)',
      name: current_user.first_name,
    })

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: event.sku,
        images: [event.photo],
        amount: amount_no_cents,
        currency: event.currency,
        quantity: 1,
  
      }],
      success_url: "http://localhost:3000/events/#{event.id}",
      cancel_url: "https://www.frontrow.host/orders/#{order.id}"
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
