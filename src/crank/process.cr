module Crank
  class Process
    @command : String
    @args : Array(String)
    getter :command, :name, :args

    def initialize(name : String, command : String, env = {} of String => String)
      @name = name
      params = executable_and_args(command)

      @command = params[:command]
      @args = params[:args]

      @process = ::Process.new(params[:command], params[:args], env: env, shell: true, output: ::Process::Redirect::Pipe, error: ::Process::Redirect::Pipe)
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

    private def executable_and_args(full_command)
      candidate_executable : String = ""
      segments : Array(String) = full_command.split(/\s+/)

      segments.each_with_index do |segment, index|
        candidate_executable += segment

        if ::Process.find_executable(candidate_executable) && File.exists?(candidate_executable) && File.executable?(candidate_executable)
          return {command: candidate_executable, args: segments[(index + 1..)]}
        else
          candidate_executable
        end
      end
      {command: full_command, args: [] of String}
    end
  end
end
