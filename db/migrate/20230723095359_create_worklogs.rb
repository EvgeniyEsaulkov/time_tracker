# frozen_string_literal: true

class CreateWorklogs < ActiveRecord::Migration[7.0]
  def change
    create_table :worklogs do |t|
      t.date :work_date
      t.decimal :hours, precision: 5, scale: 2, default: 0
      t.references :employee, foreign_key: true
      t.references :project, foreign_key: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
