namespace :song do
  desc "songs that need to be resolved"
  task :resolve_count => :environment do
    count = Song.where(stream_url: nil).count
    puts "#{count} of #{Song.count} without a stream"
  end


  desc "resolve_all_songs_missing_stream_urls"
  task :resolve => :environment do
    Song.where(stream_url: nil).each_with_index do |song, index|
      puts "#{index.to_s.rjust(3, '0')} - #{song.id}"
      song.resolve
      sleep 1
    end
  end
end

namespace :submission do
  desc "update all song counts"
  task :update => :environment do
    Submission.all.includes(:songs).each_with_index do |s, index|
      puts "#{index.to_s.rjust(3, '0')} - #{s.songs.count}"
      submission.update(songs_count: submission.songs.count)
    end
  end

  namespace :purge do
    desc "count the number of submissions without songs"
    task :count => :environment do
      subs = Submission.where(songs_count: 0).count
      sub_total = Submission.count
      "#{subs} of #{sub_total} without songs."
    end

    desc "purge all the submissions without songs."
    task :all => :environment do
        Submission.where(songs_count: 0).destroy_all
    end
  end
end