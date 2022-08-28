class CreateBoardComments < ActiveRecord::Migration[7.0]
  def change
    create_table :board_comments do |t|
      t.text :description
      t.integer   :user_id, index: true
      t.references :board, null: false, foreign_key: true
      t.integer :reply_comment_id

      t.timestamps
    end
  end
end
