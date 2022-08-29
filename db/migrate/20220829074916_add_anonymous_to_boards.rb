class AddAnonymousToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :anonymous_flag, :boolean, default: 0, null: false
  end
end
