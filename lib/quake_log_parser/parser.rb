module QuakeLogParser
  class Parser
    def initialize(filename)
      raise ArgumentError.new("Filename is required") unless filename

      @file = File.new(filename, "r")
    end

    def parse
      while (line = @file.gets)
        puts line
      end
    end
  end
end
