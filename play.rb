require_relative './lib/mine_sweeper'

mine_fields = []

puts "MINESWEEPER"
puts "(CTRL-C to exit)"

while(true) do

  puts "Enter number of rows and cols (0 0 to quit)"
  dims = gets.chomp
  r = dims.split(' ')[0]
  c = dims.split(' ')[1]

  if r == '0' and c == '0' # end of input
    puts "End of input."
    break
  end

  field = MineSweeper::MineField.new
  field.rows = r.to_i
  field.cols = c.to_i

  if field.valid?
    # Get r valid rows of data from user
    (1..r.to_i).each do |i|
      begin 
        puts "Enter row #{i}:"
        row = gets.chomp

        if field.append_row(row)
          break
        else
          puts "Invalid row"
        end
      end while (true)
    end

    # We have a full field, add to array
    mine_fields << field
  else
    puts "Invalid field width or height!\n"
  end
end

# Print all 
mine_fields.each_index do |i|
  mine_fields[i].score


  puts "Field ##{i+1}:\n"
  puts mine_fields[i].print_field_scored
  puts "\n"
end