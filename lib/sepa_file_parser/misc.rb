# frozen_string_literal: true

module SepaFileParser
  class Misc

    class << self

      # Convert a string representation of an amount to an integer representation in cents.
      # NOTE: This method does not handle amounts with more than 2 decimals.
      #       For any value with 2 decimals or less, the result will be correct and formatted
      #       to 2 decimals.
      #       For amounts with more than 2 decimals, an exception will be raised.
      #       The method is not currency aware and does not distinguish currencies without decimals.
      #
      # @param value [nil, String]
      # @return [Integer, nil]
      def to_amount_in_cents(value)
        return nil if value == nil || value.strip == ''

        # Using dollars and cents as representation for parts before and after the decimal separator
        # The decimal separator can be either a comma or a dot, depending on the locale.
        # This assumes that there are no thousand separators in the value.
        dollars, cents = value.split(/,|\./, 2)
        cents ||= '0'
        if cents.length > 2
          raise ArgumentError, "Amount has more than 2 decimals: #{value}"
        end
        format(
          '%<dollars>s%<cents>s',
          dollars: dollars,
          cents:   cents.ljust(2, '0'),
        ).to_i
      end

      # @param value [nil, String]
      # @return [BigDecimal, nil]
      def to_amount(value)
        return nil if value == nil || value.strip == ''

        BigDecimal(value.tr(',', '.'))
      end

    end

  end
end
