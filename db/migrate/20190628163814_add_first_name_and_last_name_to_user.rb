class AddFirstNameAndLastNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, after: 'email'
    add_column :users, :last_name, :string, after: 'first_name'
  end
end
