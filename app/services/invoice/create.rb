# frozen_string_literal: true

class Invoice::Create
  attr_reader :order, :status

  def initialize(order, status)
    @order = order
    @status = status
  end

  def call
    ActiveRecord::Base.transaction do
      invoice = create_invoice!
      update_order_status
      create_account_event!(invoice)
    end
  end

  def credit?
    status == 'credit'
  end

  private

  def create_invoice!
    Invoice.create!(
      order: order,
      status: credit? ? 'credit' : 'debit'
    )
  end

  def update_order_status
    new_status = credit? ? 'cancelled' : 'invoiced'
    order.update!(status: new_status)
  end

  def create_account_event!(invoice)
    invoice_topic = credit? ? 'credit' : 'debit'
    AccountEvent.create!(
      account: order.account,
      resource: invoice,
      topic: "invoice.#{invoice_topic}.create"
    )
  end
end