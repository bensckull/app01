class AddNbLivreToUser < ActiveRecord::Migration
  def change
  	add_column :users, :nb_livres, :integer
  end
end
