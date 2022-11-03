class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string    :title
      t.text      :description
      t.boolean   :danger_flag, index: true, null: false, default: 0
      t.integer   :user_id, index: true
      t.timestamps
    end
    add_index :boards, :title
    add_index :boards, :description
  end
end
