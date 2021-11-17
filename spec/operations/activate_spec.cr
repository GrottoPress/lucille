require "../spec_helper"

describe Lucille::Activate do
  it "activates user" do
    CreateUser.create(params(
      email: "me@example.net",
      level: :admin
    )) do |_, user|
      user.should be_a(User)

      user.try do |user|
        user.active?.should be_true
        user.inactive?.should be_false
        user.unactive?.should be_false
      end
    end
  end

  it "activates user in the future" do
    active_at = 2.days.from_now.to_utc

    CreateUser.create(params(
      email: "me@example.net",
      level: :admin,
      active_at: active_at
    )) do |_, user|
      user.should be_a(User)

      user.try do |user|
        user.active?.should be_false
        RecordStatus.new(user).active?(active_at).should be_true
        user.inactive?.should be_false
        user.unactive?.should be_true
      end
    end
  end

  it "activates user in the past" do
    CreateUser.create(params(
      email: "me@example.net",
      level: :admin,
      active_at: 2.days.ago.to_utc
    )) do |_, user|
      user.should be_a(User)

      user.try do |user|
        user.active?.should be_true
        RecordStatus.new(user).active?(3.days.ago).should be_false
        user.inactive?.should be_false
        user.unactive?.should be_false
      end
    end
  end

  it "sets inactive time" do
    inactive_at = 1.day.from_now.to_utc.at_beginning_of_second

    CreateUser.create(params(
      email: "me@example.net",
      level: :admin,
      inactive_at: inactive_at
    )) do |_, user|
      user.should be_a(User)

      user.try do |user|
        user.inactive_at.should eq(inactive_at)
      end
    end
  end
end
