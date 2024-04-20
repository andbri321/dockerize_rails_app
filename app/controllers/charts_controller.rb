# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :authenticate_user!

  def index # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @persontax75 = Person.category1
    @salarytax75 = @persontax75.count
    @discount75 = @persontax75.sum(:discount).to_f

    @persontax9 = Person.category2
    @salarytax9 = @persontax9.count
    @discount9 = @persontax9.sum(:discount).to_f

    @persontax12 = Person.category3
    @salarytax12 = @persontax12.count
    @discount12 = @persontax12.sum(:discount).to_f

    @persontax14 = Person.category4
    @salarytax14 = @persontax14.count
    @discount14 = @persontax14.sum(:discount).to_f
  end
end
