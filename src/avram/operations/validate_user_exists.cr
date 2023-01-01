module Lucille::ValidateUserExists
  macro included
    include Lucille::UserFromUserId

    before_save do
      validate_user_exists
    end

    private def validate_user_exists
      return unless user_id.changed?

      user_id.value.try do |value|
        return if user

        user_id.add_error Rex.t(
          :"operation.error.user_not_found",
          user_id: value
        )
      end
    end
  end
end
