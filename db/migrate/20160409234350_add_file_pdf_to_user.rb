class AddFilePdfToUser < ActiveRecord::Migration
  def change
  	add_column :users, :PDF_Cv, :string
  end
end
