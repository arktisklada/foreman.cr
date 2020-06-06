require "colorize"
require "../crank.cr"
require "./engine.cr"

module Crank
  class CLI
    ERROR_COLOR = :red
    PROCFILE = "Procfile"
    DOT_ENV = ".env"

    def self.start
      check_procfile!

      engine = Crank::Engine.new(PROCFILE, DOT_ENV)
      engine.start
    end

    def self.error(message)
      puts "ERROR: #{message}".colorize(ERROR_COLOR)
      exit 1
    end

    def self.check_procfile!
      unless File.exists?(PROCFILE)
        error("#{PROCFILE} does not exist.")
      end
    end
  end
end
