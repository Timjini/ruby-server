# frozen_string_literal: true

module Tulip
  # this call handles GET,POST,PUT,DELETE requests
  class Request
    def self.parse_request(request_line)
      method, path, version = request_line.split
      { method: method, path: path, version: version }
    end
  end
end
