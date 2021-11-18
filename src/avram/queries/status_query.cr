module Lucille::StatusQuery
  macro included
    def is_active(at time : Time = Time.utc)
      active_at.lte(time).where(&.inactive_at.is_nil.or &.inactive_at.gt(time))
    end

    def is_inactive(at time : Time = Time.utc)
      active_at.lte(time).inactive_at.is_not_nil.inactive_at.lte(time)
    end

    def is_pending(at time : Time = Time.utc)
      active_at.gt(time)
        .where(&.inactive_at.is_nil.or &.where("inactive_at > active_at"))
    end

    def is_unactive(at time : Time = Time.utc)
      active_at.gt(time)
        .inactive_at.is_not_nil
        .where("inactive_at <= active_at")
    end
  end
end
