class CreatePasswordResets::V20220803065619 < Avram::Migrator::Migration::V1
  def migrate
    create :password_resets do
      primary_key id : Int64

      add active_at : Time
      add inactive_at : Time?
      add success : Bool, default: false
    end
  end

  def rollback
    drop :password_resets
  end
end
