module GraphicalEditor
  class Command
    include Checker

    def initialize(image)
      @image = image
    end

    def route(line)
      line = line.strip.upcase.split(/\s+/)
      command = line[0].to_sym

      if routable_methods.include? command
        public_send(command, line.drop(1))
      else
        puts "WARNING: #{command} not known. Must be in #{routable_methods.join(', ')}"
      end
    end

    # C. Clears the table, setting all pixels to white (O).
    def C(*args)
      @image = Image.new(@image.cols, @image.rows) if @image
    end

    # F X Y C. Fill the region R with the colour C.
    # R is defined as: Pixel (X,Y) belongs to R.
    # Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
    def F(args)
      return unless check_dimensions(args, 3)
      cell = Cell.new *check_integers(args[0..1])
      return unless cell
      new_colour = args[2]
      existing_colour = @image.get_colour(cell)
      return if existing_colour == new_colour
      check_cells = [cell]
      until check_cells.empty?
        new_cells = fill(check_cells.pop, existing_colour, new_colour)
        check_cells.push(*new_cells.select{ |cell| @image.in?(cell)})
      end
    end

    # H X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    def H(*args)
    end

    #I M N. Create a new M x N image with all pixels coloured white (O).
    def I(args)
      return unless check_dimensions(args, 2)
      cols, rows = check_integers(args)
      return unless rows
      @image = Image.new(cols, rows)
    end

    #L X Y C. Colours the pixel (X,Y) with colour C.
    def L(args)
      return unless check_dimensions(args, 3)
      cell = Cell.new *check_integers(args[0..1])
      return unless cell.row
      unless @image.in? cell
        puts 'ERROR: Pixel out of bounds'
        return
      end
      @image.set_colour(cell, args[2])
    end

    #S. Show the contents of the current image
    def S(args)
      puts "\n=>\n"
      @image.show
    end

    # V X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    def V(*args)
    end

    # X. Terminate the session
    def X(*args)
      exit
    end

    private

    def routable_methods
      @routable_methods ||= public_methods(false).select { |meth| meth.length < 2 }
    end

    def fill(cell, existing_colour, new_colour)
      if @image.get_colour(cell) == existing_colour
        @image.set_colour(cell, new_colour)
        [
          Cell.new(cell.col,   cell.row+1),
          Cell.new(cell.col,   cell.row-1),
          Cell.new(cell.col+1, cell.row  ),
          Cell.new(cell.col-1, cell.row  ),
        ]
      else
        []
      end
    end
  end
end
