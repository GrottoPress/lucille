module Lucille::ValidateStatus
  macro included
    before_save do
      validate_active_at_required
      validate_inactive_at_gte_active_at
    end

    private def validate_active_at_required
      validate_required active_at,
        message: Rex.t(:"lucille.validate_status.active_at_required")
    end

    private def validate_inactive_at_gte_active_at
      inactive_at.value.try do |inactive|
        active_at.value.try do |active|
          return unless inactive < active

          inactive_at.add_error Rex.t(
            :"lucille.validate_status.inactive_at_gte_active_at",
            Rex.l(active),
            Rex.l(inactive)
          )
        end
      end
    end
  end
end
