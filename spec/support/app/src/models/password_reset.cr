class PasswordReset < BaseModel
  include Lucille::SuccessStatusColumns

  skip_default_columns

  primary_key id : Int64

  table :password_resets {}
end
