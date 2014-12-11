module QuakeLogParser
  class Executor
    def self.run(args)
      if args.empty?
        puts "You need to pass the log file as an argument"
        exit
      end
      QuakeLogParser::Parser.parse_from_file(File.new(args.first, "r"))
    end
  end
end
