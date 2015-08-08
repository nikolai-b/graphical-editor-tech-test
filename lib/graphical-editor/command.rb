module GraphicalEditor
  class Command

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
    end

    # F X Y C. Fill the region R with the colour C.
    # R is defined as: Pixel (X,Y) belongs to R.
    # Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
    def F(*args)
    end

    # H X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    def H(*args)
    end

    #I M N. Create a new M x N image with all pixels coloured white (O).
    def I(*args)
    end

    #L X Y C. Colours the pixel (X,Y) with colour C.
    def L(*args)
    end

    #S. Show the contents of the current image
    def S(*args)
    end

    # V X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    def V(*args)
    end

    # X. Terminate the session
    def X(*args)
    end

    private

    def routable_methods
      @routable_methods ||= public_methods(false) - [:route, :public_send]
    end
  end
end
