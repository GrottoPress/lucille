class User < BaseModel
  include Carbon::Emailable
  include Lucille::StatusColumns

  __enum Level do
    Admin
    Author
  end

  class Metadata
    include Lucille::JSON

    property height : Int32?
  end

  skip_default_columns

  primary_key id : Int64

  table :users do
    column email : String
    column level : User::Level
    column metadata : User::Metadata?, serialize: true
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
