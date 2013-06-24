# == Schema Information
#
# Table name: samples
#
#  sample_id         :string(8)        not null, primary key
#  sample_type       :string(25)       not null
#  cryobox_num       :integer          not null
#  cryobox_location  :integer          not null
#  barcode_id        :string(20)
#  processing_status :string(25)       default("Not-processed"), not null
#  serotype          :string(10)
#  path_to_sequence  :string(255)
#

class Sample < ActiveRecord::Base
  attr_accessible :sample_id, :sample_type, :cryobox_num, :cryobox_location, :processing_status

  def self.search(search)
    # this search method is a bit off...
  
    if !search.nil? && (search.match(/^\d\d\d\d[-\/\.]\d\d[-\/\.]\d\d$/) ||
                        search.match(/^\d\d[-\/\.]\d\d[-\/\.]\d\d$/) ||
                        search.match(/^\d\d[-\/\.]\d\d[-\/\.]\d\d\d\d$/))
      search_condition = 
        "sample_date = to_date(?, 'yyyy-mm-dd') or " +
        "sample_date = to_date(?, 'yy-mm-dd') or " +
        "sample_date = to_date(?, 'yyyy-dd-mm') or " +
        "sample_date = to_date(?, 'yy-dd-mm') or " +
        "sample_date = to_date(?, 'mm-dd-yyyy') or " +
        "sample_date = to_date(?, 'mm-dd-yy') or " +
        "sample_date = to_date(?, 'dd-mm-yyyy') or " +
        "sample_date = to_date(?, 'dd-mm-yy')"

      find(:all, conditions: 
           [search_condition,
            "#{search}",
            "#{search}",
            "#{search}",
            "#{search}",
            "#{search}",
            "#{search}",
            "#{search}",
            "#{search}"])
            
    elsif !search.nil? && !search.match(/^\d+$/)
      search_condition = 
        'sample_id ilike ? or ' +
        'sample_type ilike ? or ' +
        'processing_status ilike ? or ' +
        'serotype ilike ? or ' + 
        'pen_id ilike ?'

      find(:all, :conditions => 
           [search_condition,
            "%#{search}%",
            "%#{search}%",
            "#{search}%",
            "%#{search}%",
            "%#{search}%"])
    elsif search
      search_condition = 
        'sample_id ilike ? or ' +
        'sample_type ilike ? or ' +
        'cryobox_num = ? or ' +
        'cryobox_location = ? or ' +
        'processing_status ilike ? or ' +
        'serotype ilike ? or ' +
        'pen_id ilike ?'

      find(:all, :conditions => 
           [search_condition,
            "%#{search}%",
            "%#{search}%",
            "#{search}",
            "#{search}",
            "#{search}%",
            "%#{search}%",
            "%#{search}%"])
    else
      find(:all)
    end
  end
end
