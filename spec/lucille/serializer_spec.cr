require "../spec_helper"

describe Lucille::Serializer do
  it "serializes record" do
    user = UserFactory.create
    UserSerializer.new(user).to_json.should eq(%({"id":#{user.id}}))
  end
end
