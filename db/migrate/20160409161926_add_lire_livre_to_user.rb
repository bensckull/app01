class AddLireLivreToUser < ActiveRecord::Migration
  def change
  	add_column :users, :livres, :boolean
  end
end
