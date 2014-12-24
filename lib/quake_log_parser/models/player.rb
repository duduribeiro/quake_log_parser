module QuakeLogParser
  module Models
    class Player
      attr_reader :name

      def change_name(name)
        @name = name
      end
    end
  end
end
