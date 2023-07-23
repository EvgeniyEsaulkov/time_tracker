# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
