struct RecordStatus
  def initialize(@record : Lucille::StatusColumns)
  end

  def active?(at time : Time = Time.utc) : Bool
    return false if unactive?(time)
    @record.inactive_at.nil? || @record.inactive_at.not_nil! > time
  end

  # Has been deactivated
  def inactive?(at time : Time = Time.utc) : Bool
    !unactive?(time) && !active?(time)
  end

  # Is not yet active (will be active in future)
  def unactive?(at time : Time = Time.utc) : Bool
    @record.active_at > time
  end
end
