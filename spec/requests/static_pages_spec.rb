require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Neo4j App'" do
      visit '/home'
      expect(page).to have_content('Neo4j App')
    end

    it "should have the title 'Home'" do
      visit '/home'
      expect(page).to have_title("Neo4j App | Home")
    end
  end
end