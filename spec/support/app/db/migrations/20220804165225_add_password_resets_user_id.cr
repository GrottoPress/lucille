class AddPasswordResetsUserId::V20220804165225 < Avram::Migrator::Migration::V1
  def migrate
    alter :password_resets do
      add_belongs_to user : User?, on_delete: :cascade
    end
  end

  def rollback
    alter :password_resets do
      remove_belongs_to :user
    end
  end
end
