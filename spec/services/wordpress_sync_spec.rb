require 'spec_helper'

describe WordpressSync do
  describe '.fetch' do
    it 'calls fetch_by_id with an ID' do
      id = 33
      WordpressSync.should_receive(:fetch_by_id).with(id)
      WordpressSync.should_not_receive(:fetch_all)
      WordpressSync.fetch(id)

    end
    it 'calls fetch_all without an ID' do
      WordpressSync.should_not_receive(:fetch_by_id)
      WordpressSync.should_receive(:fetch_all)
      WordpressSync.fetch(nil)
    end
  end
end
