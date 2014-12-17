module QuakeLogParser
  class Executor
    def self.run(args)
      if args.empty?
        puts "You need to pass the log file as an argument"
        exit
      end
      #only implemented RegexParser, but in future can implement another parsers like TreetopParser, CitrusParser or ParsletParser.
      parser = QuakeLogParser::Parsers::RegexParser.new
      QuakeLogParser::Parser.new(parser).parse_from_file(File.new(args.first, "r"))
    end
  end
end
