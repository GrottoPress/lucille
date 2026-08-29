require "../spec_helper"

describe FakeMultipartParams do
  it "builds multipart params with form fields and files" do
    avatar = fake_file("image-bytes", "avatar.png")
    params = fake_multipart(name: "Paul", avatar: avatar)

    params.get?("name").should eq("Paul")
    file = params.get_file?("avatar").not_nil!
    file.filename.should eq("avatar.png")
    File.read(file.path).should eq("image-bytes")
  end

  it "builds array params" do
    params = fake_multipart(tags: ["a", "b"])

    params.get_all?("tags").should eq(["a", "b"])
  end

  it "builds nested params" do
    params = fake_multipart(user: {name: "Jane", age: 35})

    params.nested?("user").should eq({"name" => "Jane", "age" => "35"})
  end

  it "builds nested array params" do
    params = fake_multipart(user: {tags: ["x", "y"]})

    params.nested_arrays?("user").should eq({"tags" => ["x", "y"]})
  end

  it "builds many nested params" do
    params = fake_multipart(users: [{name: "Kofi"}, {name: "Ama"}])

    params.many_nested?(:users)
      .should(eq [{"name" => "Kofi"}, {"name" => "Ama"}])
  end

  it "builds array files" do
    doc = fake_file("doc-bytes", "doc.pdf")
    params = fake_multipart(docs: [doc])

    params.get_all_files?("docs[]").map(&.filename).should eq(["doc.pdf"])
  end

  it "builds nested files" do
    avatar = fake_file("image-bytes", "avatar.png")
    params = fake_multipart(user: {avatar: avatar})

    params.nested_file?("user")["avatar"].filename.should eq("avatar.png")
  end

  it "builds nested array files" do
    photo = fake_file("photo-bytes", "photo.jpg")
    params = fake_multipart(user: {photos: [photo]})

    params.nested_array_files?("user")["photos"]
      .map(&.filename)
      .should(eq ["photo.jpg"])
  end

  it "skips nil values" do
    params = fake_multipart(name: "Paul", age: nil)

    params.get?("name").should eq("Paul")
    params.get?("age").should be_nil
  end

  it "encodes time into value acceptable by the time adapter" do
    time = Time.local(Time::Location.load "Europe/Berlin")
    params = fake_multipart(user: {created_at: time})
    created_at = Time.adapter.parse!(params.nested(:user)["created_at"])

    created_at.should eq(time.at_beginning_of_second)
  end
end
