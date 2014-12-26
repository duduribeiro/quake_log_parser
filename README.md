# QuakeLogParser

## Setup
To use the QuakeLogParser, follow the instructions
```
    git clone git@bitbucket.org:duduribeiro/quake_log_parser.git
    cd quake_log_parser
    #run the parser
    bin/quake_log_parser.rb games.log #instead the games.log, you can pass the full path of the log that you want to analyze
```
## The code
with a binary in a bin and a lib folder, it's easy to move the code to a futurue gem project.
The binary only call the Executor class (Responsible to inject the parser to the main parser).
The main parser ( lib/quake_log_parser/parser.rb ) will read the lines from the file, and call the injected parser to process it.
The code was created based on regex to check what command the line represent (In the future would be nice to create the parse using Parslet or Treetop to create a grammar for the log parser). 

I splited the line commands in analyzers.
The `CommandAnalyzer` will check what command the line parsed represent, and will call the associated analyzer with the command.
All Regex analyzers are in lib/quake_log_parser/parsers/regex_parser/analyzers/.
To create a new analyzer, just create the file in the folder lib/quake_log_parser/parsers/regex_parser/analyzers/ and register the analyzer with a command in lib/quake_log_parser/parsers/regex_parser/regex_parser.rb in the `@analyzers_by_command` variable.