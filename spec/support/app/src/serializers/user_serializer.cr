struct UserSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def render
    {id: @user.id}
  end
end
