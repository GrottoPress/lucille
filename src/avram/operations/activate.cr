module Lucille::Activate
  macro included
    before_save do
      set_default_active_at
      set_default_inactive_at
    end

    include Lucille::ValidateStatus

    private def set_default_active_at
      return if active_at.value
      active_at.value = Time.utc
    end

    private def set_default_inactive_at
      return if inactive_at.value
      inactive_at.value = nil
    end
  end
end
