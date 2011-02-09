require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "List Members" do
  let!(:all_members) do
    3.times do
      Factory :member
    end

    Member.all
  end

  scenario "on the home page" do
    visit home_page

    all_members.each do |member|
      page.should have_content member.full_name
      page.should have_content member.github_username
      page.should have_content member.twitter_username
    end
  end
end
