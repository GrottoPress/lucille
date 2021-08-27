class DevDeliverLaterStrategy < Carbon::DeliverLaterStrategy
  def run(email, &block)
    block.call
  end
end
