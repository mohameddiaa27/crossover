class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :status
      t.integer :customer_id
      t.integer :agent_id
      t.text :body
      t.string :title
      t.datetime :closed_at

      t.timestamps
    end
  end
end
