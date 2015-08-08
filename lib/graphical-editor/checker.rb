module GraphicalEditor
  module Checker
    def check_dimensions(args, expected)
      if args.size == expected
        true
      else
        puts "ERROR: Command #{caller_locations(1,1)[0].label} must have #{expected} arguments"
      end
    end

    def check_integers(integers)
      integers = integers.map(&:to_i)
      if integers.all? { |int| int > 0 }
        integers
      else
        puts 'ERROR: Must have non-zero, numeric dimensions'
      end
    end

    def check_bounds(cell)
      @image.in?(cell.col, cell.row)
    end
  end
end
