require "../../spec_helper"

describe Lucille::Deactivate do
  it "deactivates user" do
    user = UserFactory.create

    DeactivateUser.update(user) do |operation, updated_user|
      operation.saved?.should be_true

      updated_user.status.active?.should be_false
      updated_user.status.inactive?.should be_true
    end
  end

  it "deactivates pending user" do
    active_at = 1.day.from_now.to_utc.at_beginning_of_second
    user = UserFactory.create &.active_at(active_at)

    DeactivateUser.update(user) do |operation, updated_user|
      operation.saved?.should be_true

      updated_user.status.pending?.should be_false
      updated_user.status.unactive?.should be_true
    end
  end
end
