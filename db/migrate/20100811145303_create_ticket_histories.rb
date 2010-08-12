class CreateTicketHistories < ActiveRecord::Migration
  def self.up
    create_table :ticket_histories do |t|
      t.integer :ticket_id
      t.integer :user_id
      t.text :comment, :null
      t.integer :action
      t.string :extra_info, :null

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_histories
  end
end
