# frozen_string_literal: true

# SalaryJob ApplicationJob
class SalaryJob < ApplicationJob
  queue_as :default

  def perform(person, person_params)
    inss_tax = InssManager::InssTax.new(person_params['salary'])
    person_params.merge!(discount: inss_tax.discount, salary_tax: inss_tax.salary_tax)
    person.update(person_params)
    person
  end
end
