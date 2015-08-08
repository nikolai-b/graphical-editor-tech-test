module GraphicalEditor
  class Image
    attr_reader :cols, :rows

    def initialize(cols, rows)
      @cols, @rows = cols, rows
      setup_data
    end

    def set_colour(col, row, colour)
      @data[row][col] = colour
    end

    def get_colour(col, row)
      @data[row][col]
    end

    def show
      (1..rows).each do |row|
        puts @data[row].values.join
      end
    end

    def in?(col, row)
      col > 0 && col <= cols && row > 0 && row <= rows
    end

    private

    def setup_data
      @data = {}
      (1..rows).each do |row|
        @data[row] = {}
        (1..cols).each do |col|
          @data[row][col] = 'O'
        end
      end
    end
  end
end
