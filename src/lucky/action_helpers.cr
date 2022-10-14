module Lucille::ActionHelpers
  macro included
    def remote_ip : Socket::IPAddress
      remote_ip?.not_nil!
    end

    def remote_ip? : Socket::IPAddress?
      request.remote_address.as(Socket::IPAddress)
    rescue TypeCastError
    end

    def redirect_back(
      *,
      fallback : Lucky::Action.class,
      status : HTTP::Status,
      allow_external = false
    )
      redirect_back fallback: fallback.path,
        status: status.value,
        allow_external: allow_external
    end

    def redirect_back(
      *,
      fallback : Lucky::RouteHelper,
      status : HTTP::Status,
      allow_external = false
    )
      redirect_back fallback: fallback.path,
        status: status.value,
        allow_external: allow_external
    end
  end
end
