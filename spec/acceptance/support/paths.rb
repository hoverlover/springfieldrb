module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def home_page
    "/"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
