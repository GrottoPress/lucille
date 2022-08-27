module Lucille::Status
  macro included
    @active_time : Time
    @inactive_time : Time?

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

    # Pending, but deactivated (inactive time equals active time)
    def unactive?(at time : Time = Time.utc) : Bool
      @active_time > time && !pending?(time)
    end

    def span? : Time::Span?
      @inactive_time.try { |inactive_time| inactive_time - @active_time }
    end

    def to_s(io)
      io << at(Time.utc)
    end

    def to_json(json)
      json.string(to_s)
    end
  end
end
