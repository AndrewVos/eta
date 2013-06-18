# Eta

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'eta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eta

## Usage

There are 2 ways to use Eta: around an `Eta::Process`, or with an
`Eta::Estimator`.

### Eta::Process

TODO: Write usage instructions for `Eta::Process` here

### Eta::Estimator

If you have a task, and can calculate what percentage of the task you're
finished with, you can use an `Eta::Estimator` to estimate how much time is
left, and when the task will be done.

Use it like this:

	files_to_delete = Dir.glob('junk/*')
	estimator = Eta::Estimator.new
	estimator.start!
	files_to_delete.each_with_index do |file, i|
	  File.delete(file)
	  estimator.percent_done = i.to_f / files_to_delete.size
	  puts "Should be done in #{estimator.time_left} seconds, by #{estimator.eta}"
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
