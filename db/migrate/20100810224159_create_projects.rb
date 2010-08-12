class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.boolean :is_enabled
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
