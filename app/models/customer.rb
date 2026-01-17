# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :account
  has_many :orders
end