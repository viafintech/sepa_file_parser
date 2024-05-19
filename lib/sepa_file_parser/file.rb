# frozen_string_literal: true

module SepaFileParser
  class File
    def self.parse(path)
      data = ::File.read(path)
      SepaFileParser::String.parse(data)
    end
  end
end
