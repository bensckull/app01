class AddNbFilmToUser < ActiveRecord::Migration
  def change
  	add_column :users, :nb_films, :integer
  end
end
