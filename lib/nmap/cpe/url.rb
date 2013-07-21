module Nmap
  module CPE
    #
    # Represets a [Common Platform Enumeration (CPE)][CPE] URL.
    #
    # [CPE]: http://nmap.org/book/output-formats-cpe.html
    #
    # @since 0.7.0
    #
    class URL < Struct.new(:part,:vendor,:product,:version,:update,:edition,
                           :language)

      # CPE part codes
      PARTS = {
        '/a' => :application,
        '/h' => :hardware,
        '/o' => :os
      }

      #
      # Parses a CPE URL.
      #
      # @param [String] url
      #   The raw URL.
      #
      # @return [URL]
      #   The parsed URL.
      #
      def self.parse(url)
          scheme,
          part,
          vendor,
          product,
          version,
          update,
          edition,
          language = url.split(':',8)

        unless scheme == 'cpe'
          raise(ArgumentError,"CPE URLs must begin with 'cpe:'")
        end

        vendor   = vendor.to_sym
        product  = product.to_sym
        language = language.to_sym if language

        return new(
          PARTS[part],
          vendor,
          product,
          version,
          update,
          edition,
          language
        )
      end

      #
      # Converts the CPE URL back into a String.
      #
      # @return [String]
      #   The raw CPE URL.
      #
      def to_s
        'cpe:' + [
          PARTS.invert[part],
          vendor,
          product,
          version,
          update,
          edition,
          language
        ].compact.join(':')
      end

    end
  end
end
