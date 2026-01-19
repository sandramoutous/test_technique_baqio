# frozen_string_literal: true

class Version < ApplicationRecord
  belongs_to :item, polymorphic: true
end