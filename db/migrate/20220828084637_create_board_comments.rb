class CreateBoardComments < ActiveRecord::Migration[7.0]
  def change
    create_table :board_comments do |t|
      t.text :description, length: { content: 300 }
      t.integer   :user_id, index: true
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
