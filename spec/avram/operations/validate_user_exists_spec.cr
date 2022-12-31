require "../../spec_helper"

private class SavePasswordReset < PasswordReset::SaveOperation
  permit_columns :user_id, :active_at, :success

  include Lucille::ValidateUserExists
end

describe Lucille::ValidateUserExists do
  it "validates user exists" do
    SavePasswordReset.create(params(
      user_id: 45,
      active_at: Time.utc,
      success: false
    )) do |operation, password_reset|
      password_reset.should be_nil
      operation.user_id.should have_error("operation.error.user_not_found")
    end
  end
end
