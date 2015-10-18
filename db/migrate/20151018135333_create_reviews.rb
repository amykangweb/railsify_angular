class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :author
      t.integer :stars
      t.text :body

      t.timestamps null: false
    end
  end
end
