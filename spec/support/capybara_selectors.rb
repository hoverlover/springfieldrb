Capybara.add_selector(:li) do
  xpath { |num| "./li[#{num}]" }
end
