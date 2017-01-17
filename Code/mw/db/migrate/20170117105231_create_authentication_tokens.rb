class CreateAuthenticationTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :authentication_tokens do |t|
      t.string :body
      t.type :account_type
      t.integer :account_id
      t.datetime :last_used_at
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
