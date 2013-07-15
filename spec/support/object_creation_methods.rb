module ObjectCreationMethods

  def create_submission(overrides = {})
    defaults = {
      title: "Valid Band Title", 
      body: "Valid Band Bio",
      twitter: "seainhd",
      email: "example@example.com"
    }
    Submission.create!(defaults.merge(overrides))
  end

  def create_admin
    User.create!(provider: "twitter", uid: '14828267', name: "Bob LobLaw")
  end

  def create_user(overrides = {})
    defaults = {
      provider: 'twitter', 
      uid: '1',
      name: 'Doug Funny' 
    }
    User.create!(defaults.merge(overrides))
  end

  def create_song(overrides = {})
    defaults = {
      type: "Soundcloud", 
      url: "https://soundcloud.com/yuniintaxco/echoes"
    }
    Song.create!( defaults.merge(overrides) )
  end
end
