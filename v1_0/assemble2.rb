# Starts performance clock
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

# creates array of current directory
files = Dir.entries('.')

files.delete('v1_0.csv')

# inplace sort of the array of file handles
files.sort!{|x,y| x.split('.')[1].to_i <=> y.split('.')[1].to_i}

# opens output file handle
outfile = File.open('v1_0.csv', 'w')

# creates array for partial points found at beginning or ending of
# individual csv files
partial_point = []

# counter for total points and total segmented points
num_seg_points = 0
num_points = 0

# iterates through files in current directory
# re-initializes the point_array for each file
# processed to avoid array resizing and copping
# performance issues
files.each do |file|
  point_array = []

  if file.include?('.csv')
    puts "Processing #{file}"

    infile = File.open(file, 'r')
    while line = infile.gets
      parts = line.split(',')

      # if the line starts with a ',' the split function makes a "" element at
      # the start of the parts array so we need to remove it
      parts.delete_at(0) if parts[0] == ""
      

      # adds point output file if its a full line of data
      if parts.size == 5
        outfile.puts parts.join(',')
        if parts[3].to_i != 0
          num_seg_points += 1
        end
          num_points += 1

      # holds partial point data at the end of a file
      elsif partial_point.size == 0
        partial_point += parts

      # completes partial point data with beginning of next file
      elsif parts.size > 0

        partial_point += parts
        outfile.puts partial_point.join(',')
        if partial_point[3].to_i != 0
          num_seg_points += 1
        end
        num_points += 1
        partial_point = []
      end
    end
  end

  # # writes the point data to the output file
  # point_array.each do |point|
  #   if point[3].to_i != 0
  #     num_seg_points += 1
  #   end
  #   num_points += 1
  #   outfile.puts point.join(',')
  # end
end

outfile.close

ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting

puts "Total points (including noise): #{num_points}"
puts "Total segmented points:         #{num_seg_points}"
puts "Time elapsed                    #{elapsed.round(4)} seconds"