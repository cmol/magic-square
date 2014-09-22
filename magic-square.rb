#!/usr/bin/env ruby

# Makes a multidimension array (matrix) with the width and height of n
def define_matrix(n)
	@square = Array.new(n) { Array.new(n).fill(0) }
	@size = n
	@max = @size * @size
end

# Writes to the matrix
def input(i, j, input)
	if @square[j-1][i-1] == 0
		@square[j-1][i-1] = input
	end
	#puts "Write #{input} @ array position #{j-1}, #{i-1}"
end

# Tests if the place in the matrix is free
def is_zero(x, y)
#	puts "Is #{x}, #{y} zero?"
	if @square[y-1][x-1] == 0 && y > 0 && x > 0
		#puts "Yes :)"
		return true
	else
		#puts "No! :("
		return false
	end
end

# Finds the next place to write
def next_pos
	x = @pos[0]
	y = @pos[1]
	
	if is_zero(x+1, y-1)
		@pos = [x+1, y-1]
	elsif x == @size && is_zero(1, y-1)
		@pos = [1, y-1]
	elsif y == 1 && is_zero(x+1, @size)
		@pos = [x+1, @size]
	elsif is_zero(x, y+1)
		@pos = [x, y+1]
	else
		unless @num == @max
			puts "Rule error!!!"
			puts "X: #{x}"
			puts "Y: #{y}"
			output
			exit
		end
	end
end

# Finds the start position
def start_pos
	@pos = [(@size.to_f/2+0.5).to_i, 1]
end

# Prints the table nicely
def output
	out = ""
	@square.each do | line |
		line.each do | number |
		out << number.to_s.rjust(@max.to_s.length + 1)
		end
	out << "\n"
	end
	puts out
end

#================ Running the program ===============

if $0 == __FILE__
	if ARGV.length > 0 && (ARGV[0].to_i % 2 > 0)
		define_matrix(ARGV[0].to_i)
		start_pos
	
		for k in 1..@max
			input(@pos[0], @pos[1], k)
			unless k == @max
				next_pos
			end
		end
	
		output
	else
		puts "Call with an odd number!"
	end
end
