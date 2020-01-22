# frozen_string_literal: true

class CustomFieldType < ApplicationRecord
  CUSTOM_FIELD_MODEL_TYPES = { 'dispatch_guides' => 0, 'guide_items' => 1, 'users' => 2, 'waypoints' => 3}.freeze
  belongs_to :account
  has_many :custom_fields, dependent: :delete_all
  has_many :custom_fields_type_values, dependent: :delete_all

  scope :for_web, -> { where(show_in_web: true) }
  scope :for_mobile, -> { where(show_in_mobile: true) }
  scope :guides_type_only, -> { where(model_type: CUSTOM_FIELD_MODEL_TYPES['dispatch_guides']) }
  scope :items_type_only, -> { where(model_type: CUSTOM_FIELD_MODEL_TYPES['guide_items']) }
  scope :waypoint_type_only, -> { where(model_type: CUSTOM_FIELD_MODEL_TYPES['waypoints']) }
end
