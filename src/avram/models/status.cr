module Lucille::Status
  macro included
    def to_s(io)
      io << at(Time.utc)
    end

    def at(time : Time) : Symbol
    end

    def active?(at time : Time = Time.utc) : Bool
    end

    def inactive?(at time : Time = Time.utc) : Bool
    end

      # Active in the future (from the perspective of `time`)
    def pending?(at time : Time = Time.utc) : Bool
    end

    # Pending, but deactivated (`inactive_at` equals `active_at`).
    def unactive?(at time : Time = Time.utc) : Bool
    end
  end
end
