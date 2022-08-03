struct RecordStatus
  @active_time : Time
  @inactive_time : Time?

  def initialize(record : Lucille::StatusColumns)
    @active_time = record.active_at
    @inactive_time = record.inactive_at
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
    return false if @active_time > time
    @inactive_time.nil? || @inactive_time.not_nil! > time
  end

  def inactive?(at time : Time = Time.utc) : Bool
    @active_time <= time && !active?(time)
  end

    # Active in the future (from the perspective of `time`)
  def pending?(at time : Time = Time.utc) : Bool
    return false if @inactive_time.try(&.<= @active_time)
    @active_time > time
  end

  # Pending, but deactivated (`inactive_at` equals `active_at`).
  def unactive?(at time : Time = Time.utc) : Bool
    @active_time > time && !pending?(time)
  end
end
