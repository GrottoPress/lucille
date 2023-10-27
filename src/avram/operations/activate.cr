module Lucille::Activate
  macro included
    before_save do
      set_default_active_at
    end

    include Lucille::ValidateStatus

    private def set_default_active_at
      return unless active_at.value.nil?
      active_at.value = Time.utc
    end
  end
end
