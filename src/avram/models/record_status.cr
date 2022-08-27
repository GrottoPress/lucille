require "./status"

struct RecordStatus
  include Lucille::Status

  def initialize(record : Lucille::StatusColumns)
    @active_time = record.active_at
    @inactive_time = record.inactive_at
  end
end
