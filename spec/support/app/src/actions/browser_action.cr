abstract class BrowserAction < Lucky::Action
  accepted_formats [:html, :json], default: :html
end
