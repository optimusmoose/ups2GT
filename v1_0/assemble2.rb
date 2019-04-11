points = []
points_idx = -1
files = Dir.entries(".")
files.sort!{|x,y| x.split(".")[1].to_i <=> y.split(".")[1].to_i}
last_size = 0
files.each do |file|
  if file.include?(".csv")
    puts file
    infile = File.open(file,"r")
    while line = infile.gets
      parts = line.chop.split(",")
      if(parts[3]==nil and last_size < 5)
        points[points_idx] << line
      elsif
        points << parts
        points_idx += 1
      end
      last_size = parts.size
    end
    infile.close
  end
end

num_seg_points = 0
points.each do |point|
  if point[3]!= "0" and point[3] != "-1"
    num_seg_points += 1
  end
end

puts "Total points (including noise) = #{points.size}"
puts "Total segmented points = #{num_seg_points}"

outfile = File.open("v1_0.csv","w")
points.each do |point|
  outfile.puts point.join(",")
end
outfile.close
