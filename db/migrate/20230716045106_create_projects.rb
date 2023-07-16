# frozen_string_literal: true

# This migration creates projects table
class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
