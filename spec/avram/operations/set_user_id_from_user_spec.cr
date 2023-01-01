require "../../spec_helper"

private class SavePasswordReset < PasswordReset::SaveOperation
  permit_columns :active_at, :success

  include Lucille::SetUserIdFromUser
end

describe Lucille::SetUserIdFromUser do
  it "sets user id" do
    user = UserFactory.create

    SavePasswordReset.create(
      params(active_at: Time.utc, success: false),
      user: user
    ) do |operation, password_reset|
      password_reset.should be_a(PasswordReset)

      password_reset.try do |_password_reset|
        _password_reset.user_id.should eq(user.id)
      end

      operation.user.try(&.id).should eq(user.id)
    end
  end
end
