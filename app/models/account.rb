# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :account_events
  has_many :orders
end