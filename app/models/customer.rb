# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :account
  has_many :orders

  def fullname
    "#{lastname.upcase} #{firstname.titleize}"
  end
end