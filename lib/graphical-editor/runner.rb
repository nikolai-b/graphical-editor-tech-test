module GraphicalEditor
  class Runner
    class << self
      def start
        command = Command.new(nil)
        loop do
          print '>> '
          line = gets.chomp!
          command.route(line)
        end
      end
    end
  end
end
