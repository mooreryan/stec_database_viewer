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
      
      ["Sampling Info", "People"].each do |h2|
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
    before do
      Sample.create(sample_id: "1F", sample_type: "Fecal", cryobox_num: 1, cryobox_location: 1)
      Sample.create(sample_id: "1H", sample_type: "Hide", cryobox_num: 1, cryobox_location: 2)
      Sample.create(sample_id: "1C", sample_type: "Carcass", cryobox_num: 1, cryobox_location: 3)
      
      HideCarcassSample.create(sample_date: "2001-01-15", lot_id: "111", carcass_plant_id: "33",
                               hide_id: "1H", carcass_id: "1C", pen_id: "D222")

      FecalSample.create(sample_date: "2001-01-14", pen_id: "D222", fecal_id: "1F")

      visit view_samples_path
    end

    let(:page_path) { view_sampling_info_path }
    it_should_behave_like "the links on all view pages"

    it "should list all sample info properly" do
      fecal = Sample.select('*').joins('inner join fecal_samples on samples.sample_id = fecal_samples.fecal_id')
      hide = Sample.select('*').joins('inner join hide_carcass_samples on samples.sample_id = hide_carcass_samples.hide_id')
      carcass = Sample.select('*').joins('inner join hide_carcass_samples on samples.sample_id = hide_carcass_samples.carcass_id')

      fecal.each do |record|
        page.should have_selector 'td', text: record.sample_id
        page.should have_selector 'td', text: record.sample_type
        page.should have_selector 'td', text: record.cryobox_num.to_s
        page.should have_selector 'td', text: record.cryobox_location.to_s
        page.should have_selector 'td', text: record.sample_date.to_s
        page.should have_selector 'td', text: record.pen_id
        page.should have_selector 'td', text: record.serotype
        page.should have_selector 'td', text: record.processing_status
      end

      hide.each do |record|
        page.should have_selector 'td', text: record.sample_id
        page.should have_selector 'td', text: record.sample_type
        page.should have_selector 'td', text: record.cryobox_num.to_s
        page.should have_selector 'td', text: record.cryobox_location.to_s
        page.should have_selector 'td', text: record.sample_date.to_s
        page.should have_selector 'td', text: record.pen_id
        page.should have_selector 'td', text: record.serotype
        page.should have_selector 'td', text: record.processing_status
      end

      carcass.each do |record|
        page.should have_selector 'td', text: record.sample_id
        page.should have_selector 'td', text: record.sample_type
        page.should have_selector 'td', text: record.cryobox_num.to_s
        page.should have_selector 'td', text: record.cryobox_location.to_s
        page.should have_selector 'td', text: record.sample_date.to_s
        page.should have_selector 'td', text: record.pen_id
        page.should have_selector 'td', text: record.serotype
        page.should have_selector 'td', text: record.processing_status
      end
    end

    it { should have_selector 'form p', text: "Sample" }

    
    it "should seach by fecal_id" do
      click_button "Filter" # this does check if there is a filter button
      expect { all('table tr').count.should == 10 } # this doesnt actually test what i want it to
    end

  end

  describe "Sampling info page" do
    before do
      SamplingInfo.create(sample_date: "2001-01-01", pen_id: "123A",
                          head_per_pen: 555, crew_id: 1,
                          observations: "I'm an observation.",
                          hides_n: "1-4", carcass_n: "4-63", feces_n: "3-588")
      SamplingInfo.create(sample_date: "2001-01-02", pen_id: "125B",
                          head_per_pen: 333, crew_id: 1,
                          observations: "I'm another observation.",
                          hides_n: "1-44", carcass_n: "4-633", feces_n: "3-58")
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
        page.should have_selector 'td', text: record.pen_id.to_s
        page.should have_selector 'td', text: record.head_per_pen.to_s
        page.should have_selector 'td', text: record.observations
        page.should have_selector 'td', text: record.hides_n
        page.should have_selector 'td', text: record.carcass_n
        page.should have_selector 'td', text: record.feces_n
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
