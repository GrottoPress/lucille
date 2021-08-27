class CreateUsers::V20210826205715 < Avram::Migrator::Migration::V1
  def migrate
    create :users do
      primary_key id : Int64

      add email : String, unique: true
      add level : String
    end
  end

  def rollback
    drop :users
  end
end
