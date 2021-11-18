module Lucille::Deactivate
  macro included
    before_save do
      set_default_inactive_at
      reset_inactive_at
    end

    include Lucille::ValidateStatus

    private def set_default_inactive_at
      return if inactive_at.value

      record.try do |record|
        inactive_at.value = {record.active_at, Time.utc}.max
      end
    end

    # Don't update `inactive_at` if record is already inactive
    private def reset_inactive_at
      record.try do |record|
        return unless record.status.inactive?
        inactive_at.value = inactive_at.original_value
      end
    end
  end
end
