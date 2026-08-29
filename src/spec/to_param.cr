module Lucille::ToParam
  macro included
    def to_param(value)
      case value
      when .responds_to?(:to_param)
        value.to_param
      when Time
        value.to_utc.to_rfc2822
      else
        value.to_s
      end
    end
  end
end
