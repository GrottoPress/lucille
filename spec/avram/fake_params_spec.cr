require "../spec_helper"

describe FakeParams do
  it "creates new empty params" do
    # Ensures no compile error:
    #   ```
    #   Error: can't infer block return type
    #   ```

    FakeParams.new.get?("none").should be_nil
  end

  it "encodes time into value acceptable by the time adapter" do
    time = Time.local(Time::Location.load "Europe/Berlin")
    params = fake_params(user: {created_at: time})
    created_at = Time.adapter.parse!(params.nested(:user)["created_at"])

    created_at.should eq(time.at_beginning_of_second)
  end

  describe "#nested" do
    it "returns string values for the given key" do
      params = fake_params({"user" => {name: "Alesia", age: "35"}})

      params.nested(:user).should eq({"name" => "Alesia", "age" => "35"})
      params.nested(:missing).should be_empty
    end
  end

  describe "#nested_arrays" do
    it "returns array values for the given key" do
      params = fake_params(user: {name: "Alesia", tags: ["a", "b"]})

      params.nested_arrays(:user).should eq({"tags" => ["a", "b"]})
      params.nested_arrays(:missing).should be_empty
    end
  end

  describe "#get_file" do
    it "returns uploaded file for the given key" do
      avatar = fake_file("image-bytes", "avatar.png")
      params = fake_params(avatar: avatar)

      params.get_file?(:avatar).not_nil!.filename.should eq("avatar.png")
      params.get_file?(:missing).should be_nil
    end
  end

  describe "#get_all_files" do
    it "returns array of uploaded files for the given key" do
      doc = fake_file("doc-bytes", "doc.pdf")
      params = fake_params(docs: [doc])

      params.get_all_files?(:docs)
        .not_nil!
        .map(&.filename)
        .should(eq ["doc.pdf"])

      params.get_all_files?(:missing).should be_nil
    end
  end

  describe "#nested_file" do
    it "returns uploaded files for the given key" do
      avatar = fake_file("image-bytes", "avatar.png")
      params = fake_params({"user" => {:name => "Alesia", :avatar => avatar}})

      params.nested_file(:user)["avatar"].filename.should eq("avatar.png")
      params.nested_file(:user).keys.should eq(["avatar"])
      params.nested_file("missing").should be_empty
    end
  end

  describe "#nested_array_files" do
    it "returns array of uploaded files for the given key" do
      photo = fake_file("photo-bytes", "photo.jpg")
      params = fake_params(user: {photos: [photo]})

      params.nested_array_files?(:user)["photos"]
        .map(&.filename)
        .should(eq ["photo.jpg"])

      params.nested_array_files?(:missing).should be_empty
    end
  end

  describe "#many_nested" do
    it "returns an array of hashes for the given key" do
      params = fake_params(files: [{name: "photo.jpg"}])

      params.many_nested("files").should(eq [{"name" => "photo.jpg"}])
      params.many_nested(:missing).should be_empty
    end
  end

  describe "#get?" do
    it "returns string for a given key" do
      params = fake_params({"name" => "Alesia"})

      params.get?(:name).should eq("Alesia")
      params.get?(:missing).should be_nil
    end
  end

  describe "#get_all?" do
    it "returns array for a given key" do
      params = fake_params({files: ["photo.jpg"]})

      params.get_all?(:files).should eq(["photo.jpg"])
      params.get_all?("missing").should be_nil
    end
  end
end
