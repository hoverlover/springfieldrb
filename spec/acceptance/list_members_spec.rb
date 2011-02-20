require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "List Members" do
  let!(:all_members) do
    3.times do
      Factory :member
    end

    Member.all
  end


  scenario "all members" do
    visit members_path

    within("#members") do
      all_members.each_with_index do |member, i|
        within(:li, i + 1) do
          page.should have_content(member.full_name)

          within(".social") do
            within(".github") do
              page.should have_content(member.full_name)

              within(".repositories") do
                member.github_user.public_repos.each do |repo|
                  page.should have_content(repo.name)
                end
              end
            end

            find(".twitter").text.should == member.twitter_username
          end
        end
      end
    end
  end
end
