struct PasswordResetSerializer < BaseSerializer
  def initialize(
    @params : Avram::Paramable,
    @pasword_reset : PasswordReset,
    @current_user : User? = nil
  )
  end

  def render
    PasswordResetResponseFilter.run(@pasword_reset, @params, @current_user)
  end
end
