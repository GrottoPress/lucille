class String
  # References:
  #
  # - https://en.wikipedia.org/wiki/Email_address
  # - https://support.google.com/mail/answer/9211434
  def email? : Bool
    address, _, domain = partition('@')
    return false if address.empty? || address.size > 64 || !domain.domain?
    address.matches?(/^[a-z\_](?:[a-z0-9\_]*(?<!\.)\.?)*(?<!\.)$/i)
  end

  # Reference: https://en.wikipedia.org/wiki/Domain_Name_System
  def domain? : Bool
    return false if empty? || size > 253

    matches?(
      /^(?:[a-z0-9][a-z0-9\-]{0,62}(?<!\-)\.)+[a-z][a-z0-9\-]{1,19}(?<!\-)$/i
    )
  end

  def http_url? : Bool
    return false if empty? || !url?
    scheme = URI.parse(self).scheme
    scheme.nil? || scheme.downcase.in?({"http", "https"})
  rescue URI::Error
    false
  end

  def url? : Bool
    return false if empty?

    uri = URI.parse(self)
    valid = uri.host.nil? || uri.host.to_s.domain?

    valid &&= (uri.path.empty? ||
      uri.path.matches?(/^[a-z0-9\-\_\.\%\+\/]+$/i))

    valid &&= (uri.query.nil? ||
      uri.query.to_s.matches?(/^([a-z0-9\-\_\.\:\%\+\&\=\,\[\]]+)$/i))

    valid && (uri.fragment.nil? ||
      uri.fragment.to_s.matches?(/^[a-z0-9\-\_\.\%\+]+$/i))
  rescue URI::Error
    false
  end

  def ip? : Bool
    Socket::IPAddress.valid?(self)
  end

  def ip4? : Bool
    Socket::IPAddress.valid_v4?(self)
  end

  def ip6? : Bool
    Socket::IPAddress.valid_v6?(self)
  end
end

module Avram
  module Validations
    def validate_email(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.email?
        end
      end
    end

    def validate_name(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          next if value.matches?(/^[a-z][a-z\-\'\s]*$/i)

          attribute.add_error(message)
        end
      end
    end

    def validate_unicode_name(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          next if value.matches?(/^\p{L}[\p{L}\-\'\s]*$/i)

          attribute.add_error(message)
        end
      end
    end

    def validate_username(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          next if value.matches?(/^[a-z\_][a-z0-9\_]*$/i)

          attribute.add_error(message)
        end
      end
    end

    def validate_slug(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          next if value.matches?(/^[a-z0-9\_][a-z0-9\_\-]*(?<!\-)$/i)

          attribute.add_error(message)
        end
      end
    end

    def validate_domain(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.domain?
        end
      end
    end

    def validate_domain_label(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          if value.matches?(/^(?!-)[a-zA-Z0-9-]{1,63}(?<!\-)$/i)
            next
          end

          attribute.add_error(message)
        end
      end
    end

    def validate_http_url(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.http_url?
        end
      end
    end

    def validate_url(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.url?
        end
      end
    end

    def validate_ip(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.ip?
        end
      end
    end

    def validate_ip4(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.ip4?
        end
      end
    end

    def validate_ip6(
      *attributes,
      message : Attribute::ErrorMessage = "is invalid"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) unless value.ip6?
        end
      end
    end

    def validate_positive_number(
      *attributes,
      message : Attribute::ErrorMessage = "must be positive"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) if value < 0
        end
      end
    end

    def validate_negative_number(
      *attributes,
      message : Attribute::ErrorMessage = "must be negative"
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) if value >= 0
        end
      end
    end

    def validate_foreign_key(
      attribute,
      *,
      query : Queryable,
      message : Attribute::ErrorMessage = "does not exist"
    )
      attribute.value.try do |value|
        # ameba:disable Performance/AnyInsteadOfEmpty
        unless query.where(query.primary_key_name, value).any?
          attribute.add_error(message)
        end
      end
    end

    def validate_foreign_key(
      attribute,
      *,
      query : Queryable.class,
      message : Attribute::ErrorMessage = "does not exist"
    )
      validate_foreign_key(attribute, query: query.new, message: message)
    end

    def validate_not_pwned(
      *attributes,
      message : Attribute::ErrorMessage = "appears in a known data breach",
      remote_fail : Attribute::ErrorMessage? = nil
    )
      attributes.each do |attribute|
        attribute.value.try do |value|
          attribute.add_error(message) if Pawn.pwned?(value)
        end
      rescue error
        raise error unless remote_fail
        attribute.add_error(remote_fail)
      end
    end
  end
end
