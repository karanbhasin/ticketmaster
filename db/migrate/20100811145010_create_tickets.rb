class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :title, :limit => 100
      t.integer :project_id
      t.integer :created_by_user_id
      t.integer :status, :default => 1
      t.integer :assigned_to_user_id
      t.integer :priority, :default => 1
      t.text :description, :null

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
