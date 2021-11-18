module Lucille::StatusColumns
  macro included
    column active_at : Time
    column inactive_at : Time?

    def status : RecordStatus
      RecordStatus.new(self)
    end
  end
end
