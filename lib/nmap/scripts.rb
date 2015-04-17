module Nmap
  module Scripts
    #
    # The output from the NSE scripts ran against the open port.
    #
    # @return [Hash{String => String}]
    #   The NSE script names and output.
    #
    # @since 0.3.0
    #
    def scripts
      unless @scripts
        @scripts = {}

        @node.xpath('script').each do |script|
          @scripts[script['id']] = script['output']
        end
      end

      return @scripts
    end

    #
    # The structured output of the NSE scripts.
    #
    # @return [Hash{String => Hash{String => Array<String>}}]
    #   The NSE script names and their structured output.
    #
    # @since 0.9.0
    #
    def script_data
      unless @script_data
        @script_data = {}

        @node.xpath('script').each do |script|
          id = script['id']
          @script_data[id] = {}

          script.xpath('table').each do |table|
            key = table['key']
            @script_data[id][key] = []

            table.xpath('elem').each do |elem|
              @script_data[id][key] << elem.inner_text
            end
          end
        end
      end

      return @script_data
    end

  end
end
