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

    within("ul") do
      all_members.each_with_index do |member, i|
        within(:li, i + 1) do
          page.should have_content(member.full_name)

          within("ul.social") do
            find("li.github").text.should == member.github_username
            find("li.twitter").text.should == member.twitter_username
          end
        end
      end
    end
  end
end
