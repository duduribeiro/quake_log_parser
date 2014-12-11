module QuakeLogParser
  class Parser
    def self.parse_from_file(file)
      while (line = file.gets)
        puts line
      end
    end
  end
end
