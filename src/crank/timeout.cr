module Timeout
  def self.timeout(seconds, timeout_handler, &block)
    if seconds == nil || seconds == 0
      return block.call
    end

    timeout_thread = delay(seconds) { timeout_handler.call }

    block.call
  end
end
