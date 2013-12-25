desc "Pick a random user as the winner"
task :post_to_rawrdio => :environment do
  client = Raredio::ClientLibrary.new
  Song.where(
    :created_at => 48.hours.ago..24.hours.ago, 
    :type => "Soundcloud".to_sym).each do |song|
    puts "sending song #{song.url}"
    client.create(song.url)
  end
end

desc "resolve all songs without stream urls"
task :resolve => :environment do
  Song.all.each do |song|
    puts "resolving #{song.url}"
    sleep 1
    song.resolve
  end
end
