class DeactivateUser < User::SaveOperation
  permit_columns :inactive_at

  include Lucille::Deactivate
end
