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
    before { visit view_path }

    let(:page_title) { '' }
    let(:heading) { 'View' }
    it_should_behave_like "all data pages"

    let(:page_path) { view_path }
    it_should_behave_like "the links on all view pages"
  end

  describe "Samples page" do
    before do # DOESNT WORK
      Sample.create(sample_id: "1F", sample_type: "Fecal",
                    cryobox_num: 1, cryobox_location: 1)
      Sample.create(sample_id: "2H", sample_type: "Hide",
                    cryobox_num: 1, cryobox_location: 2)
      visit view_samples_path
    end

    let(:page_path) { view_samples_path }
    it_should_behave_like "the links on all view pages"

    describe "should list all the samples" do # DOESNT WORK
      Sample.all.each do |record|
        page.should have_selector 'im not a selector', text: "i should fail"
        page.should have_selector 'td', text: record.sample_id
        page.should have_selector 'td', text: record.sample_type
        page.should have_selector 'td', text: record.cryobox_num
        page.should have_selector 'td', text: record.cryobox_location
      end
    end
  end

  describe "Sampling info page" do
    before do
      SamplingInfo.create(sample_date: "2001-01-01", pen_id: "123A",
                          head_per_pen: 555, crew_id: 1,
                          observations: "I'm an observation.")
      SamplingInfo.create(sample_date: "2001-01-02", pen_id: "125B",
                          head_per_pen: 333, crew_id: 1,
                          observations: "I'm another observation.")
      Crew.create(crew_id: 1, person_id: 1)
      Crew.create(crew_id: 1, person_id: 2)
      Person.create(person_id: 1, name: "Cliff Lee")
      Person.create(person_id: 2, name: "Dom Brown")

      visit view_sampling_info_path
    end
    
    let(:page_path) { view_sampling_info_path }
    it_should_behave_like "the links on all view pages"

    it "should list all sampling info records properly" do
      SamplingInfo.all.each do |record|
        # do i need to test for all of them?
        page.should have_selector 'td', text: record.sample_date.to_s
        # will implicitly test data_pages_controller.rb @crews assingment function
        page.should have_selector 'td#crew', text: "Cliff Lee, Dom Brown"
      end
    end

      
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
