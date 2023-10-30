class AddUsersStatusColumns::V20211116205130 < Avram::Migrator::Migration::V1
  def migrate
    alter :users do
      add active_at : Time, default: Time.utc
      add inactive_at : Time?
    end
  end

  def rollback
    alter :users do
      remove :active_at
      remove :inactive_at
    end
  end
end
