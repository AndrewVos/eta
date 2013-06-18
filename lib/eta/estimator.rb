module Eta
  class Estimator
    attr_accessor :percent_done

    def start!
      @start_time = current_time
    end

    def eta
      Time.at(current_time.to_i + time_left)
    end

    def time_left
      expected_duration - elapsed_time
    end

    def expected_duration
      elapsed_time / percent_done
    end

    def elapsed_time
      current_time - @start_time
    end

    def current_time
      Time.now.to_i
    end
  end
end
