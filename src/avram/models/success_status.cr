struct SuccessStatus
  include Lucille::Status

  def initialize(@record : Lucille::SuccessStatusColumns)
    @status = RecordStatus.new(@record)
  end

  def at(time : Time) : Symbol
    case
    when success?(time)
      :success
    when failure?(time)
      :failure
    else
      @status.at(time)
    end
  end

  def success?(at time : Time = Time.utc) : Bool
    @record.success?
  end

  def failure?(at time : Time = Time.utc) : Bool
    !success?(time) && @status.inactive?(time)
  end

  def active?(at time : Time = Time.utc) : Bool
    !success?(time) && @status.active?(time)
  end

  def inactive?(at time : Time = Time.utc) : Bool
    success?(time) || failure?(time)
  end

  # Active in the future (from the perspective of `time`)
  def pending?(at time : Time = Time.utc) : Bool
    !success?(time) && @status.pending?(time)
  end

  # Pending, but deactivated (inactive time equals active time)
  def unactive?(at time : Time = Time.utc) : Bool
    !success?(time) && @status.unactive?(time)
  end

  def span? : Time::Span?
    @status.span?
  end
end
