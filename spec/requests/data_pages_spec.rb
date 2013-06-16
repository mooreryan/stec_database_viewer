require 'spec_helper'

describe "DataPages" do
  subject { page }

  shared_examples_for "all data pages" do
    it { should have_selector 'title', text: full_title(page_title) }
    it { should have_selector 'h1', text: heading }
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
        page.should have_selector 'li', text: sample.sample_id
      end
    end
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
