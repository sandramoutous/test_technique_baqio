# frozen_string_literal: true

class OrderLine < ApplicationRecord
  belongs_to :order
end