# frozen_string_literal: true

module SepaFileParser
  module Type
    class Proprietary
      attr_reader :id, :issuer

      def initialize(id, issuer)
        @id, @issuer = id, issuer
      end
    end
  end
end
