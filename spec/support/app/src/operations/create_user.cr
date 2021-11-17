class CreateUser < User::SaveOperation
  permit_columns :email, :level, :active_at, :inactive_at

  attribute height : Int32

  before_save do
    set_height
  end

  include Lucille::Activate

  private def set_height
    height.value.try do |value|
      if metadata.value
        metadata.value.try &.height = value
        metadata.value = metadata.value.dup # Ensures `changed?` is `true`
      else
        metadata.value = User::Metadata.from_json({height: value}.to_json)
      end
    end
  end
end
