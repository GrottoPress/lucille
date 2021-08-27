abstract class ApiAction < Lucky::Action
  accepted_formats [:html, :json], default: :json

  route_prefix "/api/v0"
end
