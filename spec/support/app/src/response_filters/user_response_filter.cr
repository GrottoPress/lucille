alias UserResponse = Hash(Symbol, Union(
  Bool,
  Int64,
  String,
  User::Level,
  User::Metadata
))

struct UserResponseFilter
  include Lucille::ResponseFilter

  def initialize(@user : User)
  end

  def run(
    fields : Indexable(String)?,
    current_user : User? = nil
  ) : UserResponse
    default_response.tap do |response|
      add_email(response, fields)
      add_level(response, fields, current_user)
      add_metadata(response, fields)
    end
  end

  private def add_email(response, fields)
    return unless QueryPattern.match?("user.email", fields)

    response[:email] = @user.email
  end

  private def add_level(response, fields, current_user)
    return unless QueryPattern.match?("user.level", fields)

    current_user.try do |user|
      if user.level.admin? || user.id == @user.id
        response[:is_author] = @user.level.author?
        response[:is_admin] = @user.level.admin?
        response[:level] = @user.level
      end
    end
  end

  private def add_metadata(response, fields)
    return unless QueryPattern.match?("user.metadata", fields)

    @user.metadata.try { |metadata| response[:metadata] = metadata }
  end

  private def default_response
    UserResponse{:id => @user.id}
  end
end
