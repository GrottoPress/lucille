require "../../spec_helper"

describe Lucille::Metadata do
  it "saves metadata" do
    height = 12
    width = 32

    CreateUser.create(
      params(email: "me@example.net", level: :admin, height: height),
      metadata: User::Metadata.from_json({width: width}.to_json)
    ) do |operation, user|
      user.should be_a(User)

      user.try &.metadata.try do |metadata|
        metadata.height.should eq(height)
        metadata["width"]?.should eq(width)
      end
    end
  end
end
