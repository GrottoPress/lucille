class UserSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def render
    {type: "UserSerializer"}
  end
end
