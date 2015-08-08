module GraphicalEditor
  class Image
    attr_reader :cols, :rows

    def initialize(cols, rows)
      @cols, @rows = cols, rows
      setup_data
    end

    def set_colour(col, row, colour)
      @data[col][row] = colour
    end

    private

    def setup_data
      @data = {}
      (1..cols).each do |col|
        @data[col] = {}
        (1..rows).each do |row|
          @data[col][row] = 'O'
        end
      end
    end
  end
end
