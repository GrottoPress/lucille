require "../../spec_helper"

private class SavePasswordReset < PasswordReset::SaveOperation
  permit_columns :user_id, :active_at, :success

  include Lucille::ValidateUserExists
end

private class SavePasswordReset2 < PasswordReset::SaveOperation
  permit_columns :user_id, :active_at, :success

  include Lucille::SetUserIdFromUser
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

  it "passes if `nil` user is passed via `.needs` macro" do
    user = UserFactory.create

    SavePasswordReset2.create(
      params(
        user_id: user.id,
        active_at: Time.utc,
        success: false
      ),
      user: nil
    ) do |_, password_reset|
      password_reset.should be_a(PasswordReset)
    end
  end
end
