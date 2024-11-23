require "../spec_helper"

describe String::Lucky::Criteria do
  it "searches for single keyword" do
    {
      "mandela@abc.de",
      "delpiero@abc.de",
      "gondelar@abc.de",
      "del@abc.de",
      "dell@abc.de",
      "andel@abc.de"
    }.each do |email|
      UserFactory.create &.email(email)
    end

    UserQuery.new.email.search("del").results.map(&.email).should eq(
      [
        "del@abc.de",
        "dell@abc.de",
        "andel@abc.de",
        "mandela@abc.de",
        "delpiero@abc.de",
        "gondelar@abc.de"
      ]
    )
  end

  it "searches for multiple keywords" do
    {
      "Indeed, Kofi is a good boy",
      "Kofi is a boy",
      "Ama is a girl",
    }.each do |email|
      UserFactory.create &.email(email)
    end

    UserQuery.new.email.search("kofi").results.map(&.email).should eq(
      [
        "Kofi is a boy",
        "Indeed, Kofi is a good boy"
      ]
    )

    UserQuery.new.email.search("good boy").results.map(&.email).should eq(
      ["Indeed, Kofi is a good boy"]
    )

    UserQuery.new.email.search("kofi boy").results.map(&.email).should eq(
      [
        "Kofi is a boy",
        "Indeed, Kofi is a good boy"
      ]
    )
  end
end
