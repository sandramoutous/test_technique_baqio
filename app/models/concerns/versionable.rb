# frozen_string_literal: true

module Versionable
  extend ActiveSupport::Concern

  included do
    after_update :create_version_log
  end

  def create_version_log
    self.class::VERSIONED_COLUMNS.each do |column|
      if saved_change_to_attribute?(column)
        old_value, new_value = saved_change_to_attribute(column)

        Version.create(
          item: self,
          action: 'update',
          column: column,
          value: new_value,
          value_changed: old_value
        )
      end
    end
  end
end
