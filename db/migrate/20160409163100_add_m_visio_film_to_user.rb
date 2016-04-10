class AddMVisioFilmToUser < ActiveRecord::Migration
  def change
  	add_column :users, :m_visio_films, :string
  end
end
