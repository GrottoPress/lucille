abstract class Lucky::BaseAppServer
  def listen : Nil
    server.listen(host, port)
  end
end
