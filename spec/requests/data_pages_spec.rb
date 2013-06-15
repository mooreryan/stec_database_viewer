require 'spec_helper'

describe "DataPages" do
  subject { page }

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

end
