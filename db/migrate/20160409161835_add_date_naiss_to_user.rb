class AddDateNaissToUser < ActiveRecord::Migration
  def change
  	add_column :users, :date_naissance, :date
  end
end
