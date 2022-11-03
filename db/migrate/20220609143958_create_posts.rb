class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :danger_flag, index: true, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, :title
    add_index :posts, :content, length: { content: 400 }
  end
end
