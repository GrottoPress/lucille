struct RecordStatus
  def initialize(@record : Lucille::StatusColumns)
  end

  def to_s(io)
    io << at(Time.utc)
  end

  def at(time : Time) : Symbol
    case
    when active?(time)
      :active
    when inactive?(time)
      :inactive
    when pending?(time)
      :pending
    else
      :unactive
    end
  end

  def active?(at time : Time = Time.utc) : Bool
    return false if @record.active_at > time
    @record.inactive_at.nil? || @record.inactive_at.not_nil! > time
  end

  def inactive?(at time : Time = Time.utc) : Bool
    @record.active_at <= time && !active?(time)
  end

  def pending?(at time : Time = Time.utc) : Bool
    return false if @record.inactive_at.try(&.<= @record.active_at)
    @record.active_at > time
  end

  # Pending, but deactivated (`inactive_at` equals `active_at`).
  def unactive?(at time : Time = Time.utc) : Bool
    @record.active_at > time && !pending?(time)
  end
end
