class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.references :user, foreign_key: true, null: false
      t.string :shop_name, null: false
      t.string :caption, null: false
      t.timestamps
    end
  end
end
