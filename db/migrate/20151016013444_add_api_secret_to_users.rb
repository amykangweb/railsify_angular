class AddApiSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_secret, :string
  end
end
