class CreateUser < User::SaveOperation
  permit_columns :email, :level, :active_at, :inactive_at

  attribute height : Int32

  before_save do
    set_height
  end

  include Lucille::Activate

  private def set_height
    height.value.try do |value|
      metadata.value.try do |_metadata|
        return metadata.value = _metadata.merge(height: value)
      end

      metadata.value = User::Metadata.from_json({height: value}.to_json)
    end
  end
end
