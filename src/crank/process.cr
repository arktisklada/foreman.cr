module Crank
  class Process
    @command : String
    @args : Array(String)

    getter :command, :name, :args

    def initialize(name : String, full_command : String, env = {} of String => String)
      @name = name

      command_parts = full_command.split(/\s+/)
      @command = command_parts[0]
      @args = command_parts[1..]

      @process = ::Process.new(
        @command,
        @args,
        env: env,
        shell: true,
        output: ::Process::Redirect::Pipe,
        error: ::Process::Redirect::Pipe
      )
    end

    def run
      yield @process.output, @process.error
    end

    def wait
      @process.wait
    end

    def pid
      @process.pid
    end
  end
end
