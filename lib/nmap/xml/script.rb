module Nmap
  class XML
    #
    # Wraps a `script` XML element.
    #
    # @since 1.0.0
    #
    class Script

      #
      # Initializes a new Script object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node that contains the host information.
      #
      def initialize(node)
        @node = node
      end

      #
      # The ID of the NSE script.
      #
      # @return [String]
      #
      def id
        @id ||= @node['id']
      end

      #
      # The text output from the NSE script.
      #
      # @return [String]
      #
      def output
        @output ||= @node['output']
      end

      #
      # Parses the structured data within the `<script>` XML element.
      #
      # @return [Hash{String => Hash,Array,String}, Array<Hash>, Array<String>, nil]
      #   The parsed data.
      #
      def data
        @data ||= parse_table(@node)
      end

      private

      #
      # Parses the `<table>` XML child elements within the given node.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node that contains the host information.
      #
      # @return [Hash{String => Hash,Array,String}, Array<Hash>, Array<String>, nil]
      #   The parsed data.
      #
      def parse_tables(node)
        if (tables = node.xpath('table')).empty?
          return
        end

        # check for named tables
        if tables.all? { |table| table.has_attribute?('key') }
          Hash[
            tables.map { |table|
              [table['key'], parse_table(table)]
            }
          ]
        else
          tables.map(&method(:parse_table))
        end
      end

      #
      # Parses the contents of a `<table>` XML element.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node that contains the host information.
      #
      # @return [Hash{String => Hash,Array<String>,String}, Array<String>, nil]
      #   The parsed data.
      #
      def parse_table(node)
        # check for nested tables
        if node.xpath('count(table)') > 0
          return parse_tables(node)
        end

        if (elems = node.xpath('elem')).empty?
          # return nil if there are no elements
          return
        end

        # check for named elements
        if elems.all? { |elem| elem.has_attribute?('key') }
          Hash[
            elems.map { |elem|
              [elem['key'], elem.inner_text]
            }
          ]
        else
          elems.map(&:inner_text)
        end
      end

    end
  end
end
