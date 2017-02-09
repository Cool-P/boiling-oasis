class AddLivingToMotherDatum < ActiveRecord::Migration
  def change
    add_column 	:mother_datum, :living, :string
  end
end
