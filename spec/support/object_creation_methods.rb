module ObjectCreationMethods
  def login_admin
    OmniAuth.config.test_mode = true
    auth_credentials = {
        'uid' => '14828267',
        'provider' => 'twitter',
        'info' => {
          'name' => 'Blair Anderson'
        },
        'credentials' => {
          'secret' => "asdfghjkl",
          'token' => "lkjhgfdsa"
        }
      }
    OmniAuth.config.mock_auth[:twitter] = OpenStruct.new(auth_credentials)
    visit '/auth/twitter'
  end

  def create_submission(overrides = {})
    defaults = {
      title: "Valid Band Title",
      body: "Valid Band Bio",
      twitter: "seainhd",
      email: "example@example.com",
      songs_attributes: {"0"=>{url: "https://soundcloud.com/furns/sparks"}}
    }

    Submission.any_instance.stub(:resolve).and_return( true )
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
