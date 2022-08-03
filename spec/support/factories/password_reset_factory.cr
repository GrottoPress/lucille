class PasswordResetFactory < Avram::Factory
  def initialize
    set_defaults
  end

  private def set_defaults
    active_at Time.utc
    success false
  end
end
