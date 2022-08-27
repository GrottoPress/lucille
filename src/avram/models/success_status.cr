struct SuccessStatus
  include Lucille::Status

  def initialize(@record : Lucille::SuccessStatusColumns)
    @active_time = record.active_at
    @inactive_time = record.inactive_at
  end

  def at(time : Time) : Symbol
    case
    when success?(time)
      :success
    when failure?(time)
      :failure
    else
      previous_def(time)
    end
  end

  def success?(at time : Time = Time.utc) : Bool
    @record.success? && inactive?(time)
  end

  def failure?(at time : Time = Time.utc) : Bool
    !@record.success? && inactive?(time)
  end
end
