# frozen_string_literal: true

# Model Person
class Person < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :phones, dependent: :destroy

  accepts_nested_attributes_for :address, :phones, allow_destroy: true

  validates :name, presence: true
end
