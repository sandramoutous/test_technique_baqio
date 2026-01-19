# frozen_string_literal: true

class Order::Cancellation
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def call
    return if cancelled?

    order.update!(status: 'cancelled')
  end

  def cancelled?
    order.status == 'cancelled'
  end
end