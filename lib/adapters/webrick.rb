# frozen_string_literal: true

module Adapters
  class Webrick

    def initialize(port: 3000)
      @server = WEBrick::HTTPServer.new(Port: port)
    end

    def start
      trap('INT') { server.shutdown }

      server.start
    end

    def on(...)
      server.mount_proc(...)
    end

    private

    attr_reader :server

  end
end
