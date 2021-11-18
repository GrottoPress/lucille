module Lucille::Deactivate
  macro included
    before_save do
      set_inactive_at
    end

    private def set_inactive_at
      record.try do |record|
        return if record.status.inactive? || record.status.unactive?
        inactive_at.value = {record.active_at, Time.utc}.max
      end
    end
  end
end
