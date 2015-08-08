module GraphicalEditor
  class Image
    attr_reader :cols, :rows

    def initialize(cols, rows)
      @cols, @rows = cols, rows
      setup_data
    end

    def set_colour(cell, colour)
      @data[cell.row][cell.col] = colour
    end

    def get_colour(cell)
      @data[cell.row][cell.col]
    end

    def show
      (1..rows).each do |row|
        puts @data[row].values.join
      end
    end

    def in?(cell)
      cell.col > 0 && cell.col <= cols && cell.row > 0 && cell.row <= rows
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
