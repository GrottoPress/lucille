module Lucille::SetUserIdFromUser
  macro included
    needs user : User?

    before_save do
      set_user_id
    end

    def user! : User?
      self.user ||= user_id.value.try do |value|
        UserQuery.new.id(value).first?
      end
    end

    private def set_user_id
      user.try do |user|
        user_id.value = user.id
      end
    end
  end
end
