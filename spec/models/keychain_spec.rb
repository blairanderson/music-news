require 'spec_helper'

describe Keychain do
  describe 'associations' do
    it { should belong_to :user }
  end

  describe '.build_for_user' do
    it ''

  end
end
