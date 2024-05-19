# frozen_string_literal: true

module SepaFileParser
  module Type
    class Code
      attr_reader :code

      def initialize(code)
        @code = code
      end
    end
  end
end
