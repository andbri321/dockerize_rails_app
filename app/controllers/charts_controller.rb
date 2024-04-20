# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @person_tax_7_5 = Person.where(salary_tax:"7.5%")
    @salary_tax_7_5 = @person_tax_7_5.count
    @discount_7_5 = @person_tax_7_5.sum(:discount).to_f

    @person_tax_9 = Person.where(salary_tax:"9%")
    @salary_tax_9 = @person_tax_9.count
    @discount_9 = @person_tax_9.sum(:discount).to_f

    @person_tax_12 = Person.where(salary_tax:"12%")
    @salary_tax_12 = @person_tax_12.count
    @discount_12 = @person_tax_12.sum(:discount).to_f
    
    @person_tax_14 = Person.where(salary_tax:"14%")
    @salary_tax_14 = @person_tax_14.count
    @discount_14 = @person_tax_14.sum(:discount).to_f
  end
end
