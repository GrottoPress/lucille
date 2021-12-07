require "../../spec_helper"

private class SpecCreateUser < User::SaveOperation
  permit_columns :email, :email, :active_at, :inactive_at

  include Lucille::ValidateStatus
end

describe Lucille::ValidateStatus do
  it "requires active time" do
    SpecCreateUser.create(params(
      email: "me@example.net",
      level: :admin
    )) do |operation, user|
      user.should be_nil

      assert_invalid(operation.active_at, "operation.error.active_at_required")
    end
  end

  it "ensures active time is not later than inactive time" do
    SpecCreateUser.create(params(
      email: "me@example.net",
      level: :admin,
      active_at: Time.utc,
      inactive_at: 2.days.ago.to_utc
    )) do |operation, user|
      user.should be_nil

      assert_invalid(
        operation.inactive_at,
        "operation.error.inactive_at_earlier"
      )
    end
  end
end
