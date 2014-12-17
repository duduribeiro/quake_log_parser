module QuakeLogParser
  module Parsers
    class BaseParser
      def initialize
        @analyzers = []
      end

      def register_analyzer(*analyzer)
        @analyzers << analyzer
        @analyzers.flatten!
      end
    end
  end
end
