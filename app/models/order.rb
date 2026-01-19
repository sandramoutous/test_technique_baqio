# frozen_string_literal: true

class Order < ApplicationRecord
  include Versionable

  belongs_to :account
  belongs_to :customer
  belongs_to :fulfillment, optional: true
  has_many :order_lines, dependent: :destroy

  STATUSES = %w[
    pending
    invoiced
    validated
    cancelled
  ].freeze

  VERSIONED_COLUMNS = %w[status total_price].freeze

  validates :reference, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: STATUSES, allow_blank: false }, allow_nil: false

  STATUSES.each do |status|
    scope :"#{status}", ->{ where(status: status) }

    define_method :"#{status}?" do
      self.status == status
    end
  end

  def cancel
    return if self.cancelled?

    if self.invoiced?
      Invoice::Create.new(self, 'credit').call
    elsif self.validated?
      Order::Cancellation.new(self).call
    end
  end

  def status_name
    case status
    when 'pending' then 'En attente'
    when 'invoiced' then 'Facturé'
    when 'validated' then 'Validé'
    when 'cancelled' then 'Annulé'
    else ''
    end
  end

  def fulfillment_status
    fulfillment&.status
  end

  def total_quantity
    order_lines.sum(&:quantity) || 0
  end
end