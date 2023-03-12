# frozen_string_literal: true

require_relative 'os_class'

module Nmap
  class XML
    #
    # Represents a match for a specific {OS}.
    #
    # @since 1.0.0
    #
    class OSMatch

      #
      # Initializes the OS match.
      #
      # @param [Nokogiri::XML::Node] node
      #   The node that contains the OS match information.
      #
      # @since 1.1.0
      #
      def initialize(node)
        @node = node
      end

      #
      # The name of the OS match.
      #
      # @return [String]
      #
      def name
        @name ||= @node['name']
      end

      #
      # The accuracy of the OS match.
      #
      # @return [Integer]
      #
      def accuracy
        @accuracy ||= @node['accuracy'].to_i
      end

      #
      # The `line` attribute.
      #
      # @return [Integer]
      #
      # @since 1.1.0
      #
      def line
        @line ||= @node['line'].to_i
      end

      #
      # The OS matches OS class.
      #
      # @return [OSClass]
      #
      # @since 1.1.0
      #
      def os_class
        @os_class ||= OSClass.new(@node.at_xpath('osclass'))
      end

      #
      # Converts the OS match to a String.
      #
      # @return [String]
      #   The String form of the OS match.
      #
      def to_s
        "#{name} (#{accuracy}%)"
      end

    end
  end
end
