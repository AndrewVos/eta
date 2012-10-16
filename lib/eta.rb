require "eta/version"
require "childprocess"
require "io/console"
require "json"

module Eta
  class ProgressBar
    def initialize
      @spinner = %w{/ - \\}.cycle
    end

    def draw_spinner
      print "\r"
      print @spinner.next
      print "\r"
    end

    def draw current, total
      print "\r"
      print "["
      progress = calculate_progress(current, total)
      not_progress = screen_width - progress - 2
      progress.times { print "#" }
      not_progress.times { print " " }
      print "]"
    end

    private
      def calculate_progress current, total
        return 0 if current == 0
        progress = (Float(current) / Float(total) * screen_width) - 2
        progress = Integer(progress)
      end

      def screen_width
        rows, columns = $stdin.winsize
        columns
      end
  end

  class Process
    def initialize name, *arguments
      @name = name
      @process = ChildProcess.build(*arguments)
      @progress_bar = ProgressBar.new
      @estimated_times_json = File.expand_path(File.join(File.dirname(__FILE__), "estimated-times.json"))
      @estimated_times = lambda {
        if File.exist? @estimated_times_json
          JSON.parse(File.read(@estimated_times_json))
        else
          {}
        end
      }.call
    end

    def start
      @start_time = Time.now.to_i
      @process.start

      sleep 0.1 until @process.alive?

      while @process.alive?
        if estimated_time
          @progress_bar.draw elapsed, estimated_time
        else
          @progress_bar.draw_spinner
        end
        sleep 0.1
      end
      @estimated_times[@name] = Time.now.to_i - @start_time
      File.open(@estimated_times_json, "w") { |f| f.write(@estimated_times.to_json) }
    end

    private
      def estimated_time
        @estimated_times[@name]
      end

      def elapsed
        Time.now.to_i - @start_time
      end
  end
end
