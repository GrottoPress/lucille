class CreateUser < User::SaveOperation
  permit_columns :email, :level, :active_at, :inactive_at

  include Lucille::Activate
end
