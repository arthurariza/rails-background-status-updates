class ImportsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'imports'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
