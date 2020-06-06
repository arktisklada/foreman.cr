module Crank
  class Procfile
    @filename : String

    def initialize(filename : String)
      @filename = filename
      @entries = [] of Array(String)
      parse!
    end

    def entries(&block)
      entries.each do |entry|
        name = entry[0]
        command = entry[1]
        yield name, command
      end
    end

    private getter :filename, :entries

    private def parse!
      file_lines = File.read(filename).gsub("\r\n", "\n").split("\n")
      @entries = file_lines.map do |line|
        if line =~ /^([A-Za-z0-9_-]+):\s*(.+)$/
          [$1, $2]
        end
      end.compact
    end
  end
end
