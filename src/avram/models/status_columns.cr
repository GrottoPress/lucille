module Lucille::StatusColumns
  macro included
    column active_at : Time
    column inactive_at : Time?

    def active? : Bool
      RecordStatus.new(self).active?
    end

    # Has been deactivated
    def inactive? : Bool
      RecordStatus.new(self).inactive?
    end

    # Is not yet active (will be active in future)
    def unactive? : Bool
      RecordStatus.new(self).unactive?
    end
  end
end
