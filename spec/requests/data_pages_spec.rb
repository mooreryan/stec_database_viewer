require 'spec_helper'

describe "DataPages" do
  subject { page }
  
  shared_examples_for "data pages with no signed-in user" do
    it { should have_selector 'h1', text: "Sign in" }
  end    
  
  shared_examples_for "all data pages" do
    let(:user) { User.create(name: "Cliff", email: "happy.moo@moomint.com",
                             password: "apples", password_confirmation: "apples") }
    before { visit signin_path }
    before { sign_in user }
    before { visit page_to_test }
      
    it { should have_selector 'title', text: full_title(page_title) }
    it { should have_selector 'h1', text: heading }

    it "should have the right data page links" do
      

      click_link "Samples"
      page.should have_selector 'h2', text: "Wommack Lab Sample Info"
      
      ["Sampling Info", "People"].each do |h2|
        visit page_to_test # to bring you back to original page
        click_link h2
        page.should have_selector 'h2', text: h2
      end
    end
  end
  
  describe "View page" do
    before { visit view_path }
    
    it_should_behave_like "data pages with no signed-in user"
    
    let(:page_to_test) { view_path }
    let(:page_title) { 'View' }
    let(:heading) { 'View' }
    it_should_behave_like "all data pages"
  end

  describe "Samples page" do
    before do
      Sample.create(sample_id: "1F", sample_type: "Fecal", 
                    cryobox_num: 1, cryobox_location: 1, 
                    processing_status: 'Not-processed')
      Sample.create(sample_id: "1H", sample_type: "Hide", 
                    cryobox_num: 1, cryobox_location: 2, 
                    processing_status: 'Not-processed')
      Sample.create(sample_id: "1C", sample_type: "Carcass", 
                    cryobox_num: 1, cryobox_location: 3, 
                    processing_status: 'Processed')
      
      HideCarcassSample.create(sample_date: "2001-01-15", lot_id: "111", carcass_plant_id: "33",
                               hide_id: "1H", carcass_id: "1C", pen_id: "D222")

      FecalSample.create(sample_date: "2001-01-14", pen_id: "D222", fecal_id: "1F")

      visit view_samples_path
    end

    it_should_behave_like "data pages with no signed-in user"

    let(:page_to_test) { view_samples_path }
    let(:page_title) { 'Samples' }
    let(:heading) { 'View' }
    it_should_behave_like "all data pages"


    describe "after signing in" do
      let(:user) { User.create(name: "Cliff", email: "happy.moo@moomint.com",
                               password: "apples", password_confirmation: "apples") }

      # sign in first
      before { visit signin_path }
      before { sign_in user }
      before { visit view_samples_path }

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
      
      # will also search by sample_type, cryobox_num, cryobox_location, serotype
      
      it "should seach by sample_id" do
        fill_in "search", with: "1f"
        click_button "Search"
        expect(page).to have_selector 'table tbody tr', count: 1
        
        fill_in 'search', with: '1Q'
        click_button 'Search'
        expect(page).to have_no_selector 'table tbody tr'
      end
      
      it "should seach by pen_id" do
        fill_in "search", with: "D222"
        click_button "Search"
        expect(page).to have_selector 'table tbody tr', count: 3
        
        fill_in "search", with: "222"
        click_button "Search"
        expect(page).to have_selector 'table tbody tr', count: 3
        
        fill_in "search", with: "X3894"
        click_button "Search"
        expect(page).to have_no_selector 'table tbody tr'
      end
      
      it "should search by processing_status" do
        fill_in "search", with: "not-processed"
        click_button "Search"
        expect(page).to have_selector 'table tbody tr', count: 2
        
        fill_in "search", with: "processed"
        click_button "Search"
        expect(page).to have_selector 'table tbody tr', count: 1
      end
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
    

    it_should_behave_like "data pages with no signed-in user"

    let(:page_to_test) { view_sampling_info_path }
    let(:page_title) { 'Sampling Info' }
    let(:heading) { 'View' }
    it_should_behave_like "all data pages"


    describe "after signing in" do 
      # sign in first
      let(:user) { User.create(name: "Cliff", email: "happy.moo@moomint.com",
                               password: "apples", password_confirmation: "apples") }
      before { visit signin_path }
      before { sign_in user }
      before { visit view_sampling_info_path }

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
  end

  describe "People page" do
    let(:page_to_test) { view_people_path }
    let(:page_title) { 'People' }
    let(:heading) { 'View' }
    it_should_behave_like "all data pages"
  end


end
