require "../spec_helper"

describe ".__enum" do
  describe ".parse" do
    it "parses enum" do
      level = User::Level.new(:author)
      User::Level.adapter.parse!(level).should eq(level)
    end

    it "parses string" do
      level = User::Level.new(:author)
      User::Level.adapter.parse!("aUTHoR").should eq(level)
    end

    it "parses symbol" do
      level = User::Level.new(:author)
      User::Level.adapter.parse!(:aUTHoR).should eq(level)
    end

    it "parses array of enums" do
      levels = [User::Level.new(:author)]
      User::Level.adapter.parse!(levels).should eq(levels)
    end

    it "parses array of strings" do
      levels = [User::Level.new(:author)]
      User::Level.adapter.parse!(["author"]).should eq(levels)
    end

    it "parses array of symbols" do
      levels = [User::Level.new(:author)]
      User::Level.adapter.parse!([:author]).should eq(levels)
    end

    it "works with queries" do
      UserFactory.create &.level(:admin)
      # ameba:disable Performance/AnyInsteadOfEmpty
      UserQuery.new.level(:admin).any?.should be_true
    end
  end

  describe ".to_db" do
    it "works" do
      level = User::Level.new(:author)

      User::Level.adapter.to_db!(level).should eq("Author")
      User::Level.adapter.to_db!([level, level]).should eq("{Author,Author}")
    end
  end
end
