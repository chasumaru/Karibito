class AddAnonymousToBoardsAndBoardComments < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :anonymous_flag, :boolean, default: 0, null: false
    add_column :board_comments, :anonymous_flag, :boolean, default: 0, null: false
  end
end