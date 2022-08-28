class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :title
      t.text :description
      t.integer   :user_id, index: true
      t.timestamps
    end
  end
end
