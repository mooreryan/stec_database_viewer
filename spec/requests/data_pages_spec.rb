require 'spec_helper'

describe "DataPages" do
  subject { page }

  shared_examples_for "all data pages" do
    it { should have_selector 'title', text: full_title(page_title) }
    it { should have_selector 'h1', text: heading }
  end

  describe "View page" do
    before { visit view_path }
    let(:page_title) { '' }
    let(:heading) { 'View' }

    it_should_behave_like "all data pages"
  end

  describe "Add page" do
    before { visit add_path }
    let(:page_title) { '' }
    let(:heading) { 'Add' }

    it_should_behave_like "all data pages"
  end

  describe "Edit page" do
    before { visit edit_path }
    let(:page_title) { '' }
    let(:heading) { 'Edit' }

    it_should_behave_like "all data pages"
  end

end
