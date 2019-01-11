class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :comment
      t.string :label
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
