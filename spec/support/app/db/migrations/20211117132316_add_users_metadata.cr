class AddUsersMetadata::V20211117132316 < Avram::Migrator::Migration::V1
  def migrate
    alter :users do
      add metadata : JSON::Any?
    end
  end

  def rollback
    alter :users do
      remove :metadata
    end
  end
end
