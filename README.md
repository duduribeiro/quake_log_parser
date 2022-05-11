# Quake Log Parser

## Setup

To setup the QuakeLog parser on your machine, follow the instructions:

* Install ruby 3~ and bundler `gem install bundler`
* Clone this repo
* cd to the repo folder
* Run `bundle` to install the dependencies
* Run the tests via `rake`
* To run the parser itself, run `bin/quake_log_parser.rb qgames.txt` where qgames.txt is the path to the log file.

Or you can execute a devcontainer via VSCode.

* Follow this to setup devcontainer on your VSCode https://code.visualstudio.com/docs/remote/containers-tutorial and use the `Remote-Containers: Open Folder in Container` command to start the devcontainer
* After started go to the terminal and run `bundle` and `rake` to install the dependencies and run the tests.
* To run the parser itself, run `bin/quake_log_parser.rb qgames.txt` where qgames.txt is the path to the log file.


Running devcontainer via vscode:
https://user-images.githubusercontent.com/771411/167949279-1dba296e-ab3d-4c9c-9566-f608d06d3981.mov



## The Code
With the CLI code located at `bin` and a separated lib folder, it's easy to move the code to a future gem project.

The bin script only call the Parser class. This Parser is responsible to read the lines and get the respective command from the log line by calling the Regex ParseStrategy. The Regex Parse Strategy will read match the line using a Regex pattern to check what command the line represent (In the future would be nice to create the parse using Parslet or Treetop to create a grammar for the log parser).

The ParseStrategy returns a Command object that the parser will execute it. If a new command need to be created, just create a new command.

The Parser reads the file sequential, which may be a bad approach for huge text files. In future a ParallelParser could be implemented where we can split a file and use two or more processes to read them in parallel.

A nice improve that could be implemented would be create an InMemoryDataStore to store everything that we are saving and in future, another stores could be injected as an alternative (eg: RedisStorage).
