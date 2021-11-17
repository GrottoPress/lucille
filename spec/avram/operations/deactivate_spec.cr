require "../../spec_helper"

describe Lucille::Deactivate do
  it "deactivates user" do
    user = UserFactory.create

    DeactivateUser.update(user) do |operation, updated_user|
      operation.saved?.should be_true
      updated_user.inactive?.should be_true
    end
  end

  it "deactivates user in the future" do
    inactive_at = 1.day.from_now.to_utc.at_beginning_of_second
    user = UserFactory.create

    DeactivateUser.update(
      user,
      params(inactive_at: inactive_at)
    ) do |operation, updated_user|
      operation.saved?.should be_true

      updated_user.active?.should be_true
      updated_user.inactive?.should be_false
      RecordStatus.new(updated_user).inactive?(inactive_at).should be_true
    end
  end

  it "deactivates user in the past" do
    inactive_at = 1.day.ago.to_utc.at_beginning_of_second
    user = UserFactory.create &.active_at(3.days.ago.to_utc)

    DeactivateUser.update(
      user,
      params(inactive_at: inactive_at)
    ) do |operation, updated_user|
      operation.saved?.should be_true

      updated_user.active?.should be_false
      updated_user.inactive?.should be_true
      RecordStatus.new(updated_user).inactive?(2.days.ago).should be_false
    end
  end
end
