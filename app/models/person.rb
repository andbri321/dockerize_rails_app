# frozen_string_literal: true

# Model Person
class Person < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :phones, dependent: :destroy

  accepts_nested_attributes_for :address, :phones, allow_destroy: true

  validates :name, presence: true
  validate :cpf_validation

  scope :category1, -> { where(salary_tax: '7.5%') }
  scope :category2, -> { where(salary_tax: '9%') }
  scope :category3, -> { where(salary_tax: '12%') }
  scope :category4, -> { where(salary_tax: '14%') }

  private

  def cpf_validation
    return unless cpf.present? && !::CPF.valid?(cpf)

    errors.add(:cpf, 'invalido')
  end
end
