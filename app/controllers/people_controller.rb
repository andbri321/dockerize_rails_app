# frozen_string_literal: true

# CRUD of people
class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: %i[show edit update destroy]
  before_action :set_inss_tax, only: %i[create]

  # GET /people or /people.json
  def index
    filter_by = ["7.5%","9%","12%","14%"]

    if params[:category]
      @people = Person.where(salary_tax:filter_by[params[:category].to_i-1]).order(:name).page params[:page]
    else
      @people = Person.order(:name).page params[:page]
    end
  end

  # GET /people/1 or /people/1.json
  def show; end

  # GET /people/new
  def new
    @person = Person.new
    @person.build_address
    2.times { @person.phones.build }
  end

  # GET /people/1/edit
  def edit
    qtd = 2 - @person.phones.count
    qtd.times { @person.phones.build } if @person.phones.count != 2
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params.merge(@inss_tax_hash))
    @person.save
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      @person = SalaryJob.perform_now(@person, person_params)
      format.js
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  def set_inss_tax
    inss_tax = InssManager::InssTax.new(person_params[:salary])
    @inss_tax_hash = { discount: inss_tax.discount, salary_tax: inss_tax.salary_tax }
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(:name, :cpf, :birth_date, :salary,:category,
                                   address_attributes: %i[id street number neighborhood city person _destroy],
                                   phones_attributes: %i[id number _destroy])
  end
end
