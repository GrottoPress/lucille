require "../../spec_helper"

describe Lucille::JSON do
  it "saves metadata" do
    height = 12

    CreateUser.create(
      params(email: "me@example.net", level: :admin, height: height),
      metadata: User::Metadata.from_json({height: 32}.to_json)
    ) do |_, user|
      user.should be_a(User)
      user.try(&.metadata).should be_a(User::Metadata)

      user.try &.metadata.try do |metadata|
        metadata.height.should eq(height)
      end
    end
  end
end
