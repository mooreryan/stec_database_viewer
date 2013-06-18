require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector 'title', text: full_title(page_title) }
    it { should have_selector 'h1', text: heading }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Moomint Bovine Database Configurator' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:page_title) { '' }
    let(:heading) { 'About' }

    it_should_behave_like "all static pages"
  end
    
  describe "Contact page" do
    before { visit contact_path }
    let(:page_title) { '' }
    let(:heading) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    let(:page_title) { '' }
    let(:heading) { 'Help' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path

    # Main navigation links
    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "View"
    page.should have_selector 'title', text: full_title('View')
    click_link "Add"
    page.should have_selector 'title', text: full_title('Add')
    click_link "Edit"
    page.should have_selector 'title', text: full_title('Edit')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
  end
    
end
