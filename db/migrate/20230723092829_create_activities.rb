# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :business, null: false, default: true

      t.timestamps
    end
  end
end
