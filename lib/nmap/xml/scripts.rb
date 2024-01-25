require_relative 'script'

module Nmap
  class XML
    #
    # Mixin that adds methods for parsing `<script>` XML elements.
    #
    # @since 1.0.0
    #
    module Scripts
      #
      # The output from the NSE script's output and structured data.
      #
      # @return [Hash{String => Script}]
      #   The NSE script names and output.
      #
      # @since 0.3.0
      #
      def scripts
        unless @scripts
          @scripts = {}

          @node.xpath('script').each do |script|
            @scripts[script['id']] = Script.new(script)
          end
        end

        return @scripts
      end
    end
  end
end
