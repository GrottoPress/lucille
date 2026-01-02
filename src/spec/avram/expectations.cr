# This is now part of Avram
#
# See <https://github.com/luckyframework/avram/pull/1062>

def have_error(message = nil)
  Lucille::HaveErrorExpectation.new(message)
end

def have_error(key : Symbol, message = nil)
  Lucille::HaveErrorExpectation.new(message, key)
end

struct Lucille::HaveErrorExpectation
  def initialize(@message : Regex? = nil, @key : Symbol? = nil)
  end

  def self.new(message : String, key = nil)
    regex = message.try { |_message| /#{_message}/ }
    new(regex, key)
  end

  def match(attribute : Avram::Attribute) : Bool
    return !attribute.errors.empty? unless @message
    attribute.errors.any?(&.=~ @message.not_nil!)
  end

  def match(operation : Avram::OperationErrors) : Bool
    errors = operation.errors[@key.not_nil!]?
    return !!errors.try(&.empty?.!) unless @message
    !!errors.try(&.any? &.=~ @message.not_nil!)
  end

  def failure_message(attribute : Avram::Attribute) : String
    @message.try do |message|
      return "Expected :#{attribute.name} to have the error '#{message.source}'"
    end

    "Expected :#{attribute.name} to have an error"
  end

  def failure_message(operation : Avram::OperationErrors) : String
    @message.try do |message|
      return "Expected :#{@key.not_nil!} to have the error '#{message.source}'"
    end

    "Expected :#{@key.not_nil!} to have an error"
  end

  def negative_failure_message(attribute : Avram::Attribute) : String
    @message.try do |message|
      return "Expected :#{attribute.name} to not have the error '#{message.source}'"
    end

    <<-MSG
    Expected :#{attribute.name} to not have an error, got errors:
    #{list attribute.errors}
    MSG
  end

  def negative_failure_message(operation : Avram::OperationErrors) : String
    @message.try do |message|
      return "Expected :#{@key.not_nil!} to not have the error '#{message.source}'"
    end

    <<-MSG
    Expected :#{@key.not_nil!} to not have an error, got errors:
    #{list operation.errors[@key.not_nil!]}
    MSG
  end

  private def list(errors)
    errors.join do |error|
      <<-ERROR
        - #{error}

      ERROR
    end
  end
end
