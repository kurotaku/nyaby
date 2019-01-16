class AddPrefToSpots < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :zipcode, :string
    add_column :spots, :pref, :string
    add_column :spots, :city, :string
    add_column :spots, :town, :string
    add_column :spots, :image, :string
  end
end
