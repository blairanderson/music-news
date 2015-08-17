namespace :wordpress do
  desc "fetch recent songs from wordpress"
  task sync: :environment do
    WordpressSync.fetch
  end
end
