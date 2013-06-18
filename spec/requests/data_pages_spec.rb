require 'spec_helper'

describe "DataPages" do
  subject { page }

  shared_examples_for "all data pages" do
    it { should have_selector 'title', text: full_title(page_title) }
    it { should have_selector 'h1', text: heading }
  end

  shared_examples_for "the links on all view pages" do
    it "should have the right links on the layout" do
      visit page_path
      click_link "Samples"
      page.should have_selector 'h2', text: "Wommack Lab Sample Info"
      
      ["Sampling Info", "Fecal Samples", "Hide Samples", "People"].each do |h2|
        visit page_path # to bring you back to original page
        click_link h2
        page.should have_selector 'h2', text: h2
      end
    end
  end

  describe "View page" do
    before do
      Sample.create(sample_id: "1F", sample_type: "Fecal",
                    cryobox_num: 1, cryobox_location: 1)
      Sample.create(sample_id: "2F", sample_type: "Fecal",
                    cryobox_num: 1, cryobox_location: 2)
      visit view_path
    end

    let(:page_title) { '' }
    let(:heading) { 'View' }
    it_should_behave_like "all data pages"

    it "should list all fecal samples" do
      Sample.all.each do |sample|
        # not sure how to test for all five things...
        page.should have_selector 'td', text: sample.sample_id
      end
    end

    let(:page_path) { view_path }
    it_should_behave_like "the links on all view pages"
  end

  describe "Samples page" do
    let(:page_path) { view_samples_path }
    it_should_behave_like "the links on all view pages"
  end

  describe "Sampling info page" do
    let(:page_path) { view_sampling_info_path }
    it_should_behave_like "the links on all view pages"
  end

  describe "Fecal samples page" do
    let(:page_path) { view_fecal_samples_path }
    it_should_behave_like "the links on all view pages"
  end

  describe "Hide samples page" do
    let(:page_path) { view_hide_samples_path }
    it_should_behave_like "the links on all view pages"
  end

  describe "People page" do
    let(:page_path) { view_people_path }
    it_should_behave_like "the links on all view pages"
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
