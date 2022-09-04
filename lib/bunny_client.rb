class BunnyClient
  class << self
    # Connect
    def connect!
      @connection = Bunny.new(ENV['CLOUDAMQP_URL'])
      @connection.start
      # Create Channel
      @channel = @connection.create_channel
      # Starts Fanout
      @fan_out = @channel.fanout('aceleracao_dio_users.out')
      @connected = true
    end

    def push(payload, model)
      connect! unless @connected
      @fan_out.publish(payload, { app_id: 'aceleracao_dio_users', model: model })

      true
    end
  end
end
