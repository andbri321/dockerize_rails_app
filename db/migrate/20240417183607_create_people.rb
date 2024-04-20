# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :cpf
      t.date :birth_date
      t.decimal :salary, precision: 10, scale: 2
      t.decimal :discount, precision: 10, scale: 2, default: 0.0
      t.string :salary_tax

      t.timestamps
    end
  end
end
