require "../spec_helper"

describe FakeFormParams do
  it "builds form params from a named tuple" do
    params = fake_form({:name => "Paul", "age" => 30})

    params.get?(:name).should eq("Paul")
    params.get?("age").should eq("30")
  end

  it "builds array params" do
    params = fake_form(tags: ["a", "b"])

    params.get_all?("tags").should eq(["a", "b"])
  end

  it "builds nested params" do
    params = fake_form(user: {name: "Jane", age: 35})

    params.nested?("user").should eq({"name" => "Jane", "age" => "35"})
  end

  it "builds nested array params" do
    params = fake_form(user: {tags: ["x", "y"]})

    params.nested_arrays?("user").should eq({"tags" => ["x", "y"]})
  end

  it "builds many nested params" do
    params = fake_form(users: [{name: "Kofi"}, {name: "Ama"}])

    params.many_nested?(:users)
      .should(eq [{"name" => "Kofi"}, {"name" => "Ama"}])
  end

  it "skips nil values" do
    params = fake_form(name: "Paul", age: nil)

    params.get?(:name).should eq("Paul")
    params.get?("age").should be_nil
  end

  it "encodes time into value acceptable by the time adapter" do
    time = Time.local(Time::Location.load "Europe/Berlin")
    params = fake_form(user: {created_at: time})
    created_at = Time.adapter.parse!(params.nested(:user)["created_at"])

    created_at.should eq(time.at_beginning_of_second)
  end
end
