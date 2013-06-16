# == Schema Information
#
# Table name: hide_carcass_samples
#
#  sample_date      :date             not null
#  lot_id           :string(8)
#  carcass_plant_id :string(8)        not null, primary key
#  pen_id           :string(8)        not null
#

class HideCarcassSample < ActiveRecord::Base
end

