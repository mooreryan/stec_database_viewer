require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "Moomint Bovine Database Configurator" }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "About" }
  end
    
  describe "View page" do
    before { visit view_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "View" }
  end

  describe "Add page" do
    before { visit add_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "Add" }
  end

  describe "Edit page" do
    before { visit edit_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "Edit" }
  end

  describe "Contact page" do
    before { visit contact_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "Contact" }
  end

  describe "Help page" do
    before { visit help_path }
    it { should have_selector 'title', text: full_title('') }
    it { should have_selector 'h1', text: "Help" }
  end

end
