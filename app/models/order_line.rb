# frozen_string_literal: true

class OrderLine < ApplicationRecord
  include Versionable

  belongs_to :order

  VERSIONED_COLUMNS = %w[unit_price].freeze
end