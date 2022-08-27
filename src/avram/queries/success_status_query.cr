module Lucille::SuccessStatusQuery
  macro included
    include Lucille::StatusQuery

    def is_success(at time : Time = Time.utc)
      success(true).is_inactive(time)
    end

    def is_failure(at time : Time = Time.utc)
      success(false).is_inactive(time)
    end
  end
end
