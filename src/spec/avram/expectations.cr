def have_error(message : String? = nil)
  Lucille::HaveErrorExpectation.new(message)
end

def have_error(key : Symbol, message : String? = nil)
  Lucille::HaveErrorExpectation.new(message, key)
end

struct Lucille::HaveErrorExpectation
  def initialize(@message : String? = nil, @key : Symbol? = nil)
  end

  def match(attribute : Avram::Attribute) : Bool
    return !attribute.errors.empty? unless @message
    attribute.errors.any?(&.includes? @message.not_nil!)
  end

  def match(operation : Avram::Callbacks)
    errors = operation.errors[@key.not_nil!]?
    return !!errors.try(&.empty?.!) unless @message
    !!errors.try(&.any? &.includes? @message.not_nil!)
  end

  def failure_message(attribute : Avram::Attribute) : String
    if @message
      "Expected :#{attribute.name} to have the error '#{@message}'"
    else
      "Expected :#{attribute.name} to have an error"
    end
  end

  def failure_message(operation : Avram::Callbacks) : String
    if @message
      "Expected :#{@key.not_nil!} to have the error '#{@message}'"
    else
      "Expected :#{@key.not_nil!} to have an error"
    end
  end

  def negative_failure_message(attribute : Avram::Attribute) : String
    @message.try do |message|
      return "Expected :#{attribute.name} to not have the error '#{message}'"
    end

    <<-MSG
    Expected :#{attribute.name} to not have an error, got errors:
    #{list attribute.errors}
    MSG
  end

  def negative_failure_message(operation : Avram::Callbacks) : String
    @message.try do |message|
      return "Expected :#{@key.not_nil!} to not have the error '#{message}'"
    end

    <<-MSG
    Expected :#{@key.not_nil!} to not have an error, got errors:
    #{list operation.errors[@key.not_nil!]}
    MSG
  end

  private def list(errors)
    errors.map do |error|
      <<-ERROR
        - #{error}

      ERROR
    end.join
  end
end
