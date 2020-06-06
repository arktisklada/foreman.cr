module Crank
  class Env
    @filename : String
    @entries : Array(Array(String))

    def initialize(filename : String)
      @filename = filename
      @entries = parse
    end

    def entries(&block)
      entries.each do |entry|
        key = entry[0]
        value = entry[1]
        yield key, value
      end
    end

    private getter :filename, :entries

    private def parse
      puts "Loading environment variables from #{filename}"

      file_lines = File.read(filename).gsub("\r\n", "\n").split("\n")
      file_lines.map do |line|
        if line =~ /\A([A-Za-z_0-9]+)=(.*)\z/
          key = $1
          value = $2.rstrip
          if /\A'(.*)'\z/
            # Remove single quotes
            value = $1
          elsif /\A"(.*)"\z/
            # Remove double quotes and unescape string preserving newline characters
            value = $1.gsub('\n', "\n").gsub(/\\(.)/, "\\1", true)
          end

          [key, value]
        end
      end.compact
    end
  end
end
