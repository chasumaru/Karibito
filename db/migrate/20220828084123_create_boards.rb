class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string    :title
      t.text      :description, length: { description: 500 }
      t.boolean   :danger_flag, index: true, null: false, default: 0
      t.integer   :user_id, index: true
      t.timestamps
    end
    add_index :boards, :title
  end
end
