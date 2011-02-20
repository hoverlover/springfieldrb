require 'spec_helper'
require 'social_feeds_updater'

describe SocialFeedsUpdater do
  describe ".update" do
    it "should retrieve all the members with GitHub usernames" do
      mock(Member).github_members { stub!.each { [] } }
      SocialFeedsUpdater.update
    end

    it "should update a member's list of repositories from GitHub and store them in Redis"
    it "should update a member's list of commits from GitHub and store them in Redis"
  end
end
