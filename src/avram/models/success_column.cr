module Lucille::SuccessColumn
  macro included
    include Lucille::StatusColumns

    column success : Bool

    def status : SuccessStatus
      SuccessStatus.new(self)
    end
  end
end
