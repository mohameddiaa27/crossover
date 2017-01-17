class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :ticket_id
      t.string :account_type
      t.integer :account_id

      t.timestamps
    end
  end
end
