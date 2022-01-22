def be_valid(message : String? = nil)
  Lucille::BeValidExpectation.new(message)
end

def be_valid(key : Symbol, message : String? = nil)
  Lucille::BeValidExpectation.new(message, key)
end

struct Lucille::BeValidExpectation
  def initialize(@message : String? = nil, @key : Symbol? = nil)
  end

  def match(attribute : Avram::Attribute) : Bool
    return attribute.errors.empty? unless @message
    attribute.errors.none?(&.includes? @message.not_nil!)
  end

  def match(operation : Avram::Callbacks)
    return operation.errors[@key.not_nil!]?.nil? unless @message
    !operation.errors[@key.not_nil!]?.try &.any? &.includes?(@message.not_nil!)
  end

  def failure_message(attribute : Avram::Attribute) : String
    message = "Expected :#{attribute.name} to be valid, got errors:"

    attribute.errors.each do |error|
      message += "\n  - #{error}"
    end

    message
  end

  def failure_message(operation : Avram::Callbacks) : String
    message = "Expected :#{@key.not_nil!} to be valid, got errors:"

    operation.errors[@key.not_nil!].each do |error|
      message += "\n  - #{error}"
    end

    message
  end

  def negative_failure_message(attribute : Avram::Attribute) : String
    "Expected :#{attribute.name} to be invalid"
  end

  def negative_failure_message(operation : Avram::Callbacks) : String
    "Expected :#{@key.not_nil!} to be invalid"
  end
end
