require 'nmap/cpe/url'

module Nmap
  #
  # Mixins that adds methods for parsing [Common Platform Enumeration
  # (CPE)][CPE] information.
  #
  # [CPE]: http://nmap.org/book/output-formats-cpe.html
  #
  # @since 0.7.0
  #
  module CPE
    #
    # Parses each Common Platform Enumeration (CPE) String.
    #
    # @yield [cpe]
    #   Passes each CPE URL to the given block.
    #
    # @yieldparam [URL] cpe
    #   The CPE URL.
    #
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_cpe
      return enum_for(__method__) unless block_given?

      @node.xpath('//cpe').each do |cpe|
        yield URL.parse(cpe.inner_text)
      end

      return self
    end

    #
    # Parses each Common Platform Enumeration (CPE) String.
    #
    # @return [Array<URL>]
    #   The CPE URLs.
    #
    def cpe
      each_cpe.to_a
    end
  end
end
