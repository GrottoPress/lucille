abstract class Lucky::BaseAppServer
  def listen : Nil
    workers.times { server.bind_tcp(host, port, reuse_port ) }
    server.listen
  end

  # Override this to change number of server sockets to run
  def workers : Int32
    1
  end

  private def reuse_port
    workers > 1
  end
end
