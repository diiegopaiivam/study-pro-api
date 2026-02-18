class RenameUsersIdToUserIdOnSubjects < ActiveRecord::Migration[8.0]
  def change
    rename_column :subjects, :users_id, :user_id
  end
end
