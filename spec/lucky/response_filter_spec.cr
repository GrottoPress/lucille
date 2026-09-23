require "../spec_helper"

describe Lucille::ResponseFilter do
  it "filters response" do
    user = UserFactory.create
    password_reset = PasswordResetFactory.create &.user_id(user.id)

    params = fake_form(fields: {"password_reset.id", "user.id"})
    password_reset = PasswordResetPreloader.run(password_reset, params)

    PasswordResetSerializer.new(params, password_reset).to_json.should eq({
      id: password_reset.id,
      user: {id: user.id},
      user_id: user.id
    }.to_json)
  end
end
