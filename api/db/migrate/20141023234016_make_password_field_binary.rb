class MakePasswordFieldBinary < ActiveRecord::Migration
  def change

    change_column :users, :password_hash, :binary
    change_column :users, :password_salt, :binary

  end
end
