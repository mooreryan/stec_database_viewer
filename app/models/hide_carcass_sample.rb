# == Schema Information
#
# Table name: hide_carcass_samples
#
#  sample_date      :date             not null
#  lot_id           :string(8)        not null
#  carcass_plant_id :string(8)        not null, primary key
#  hide_id          :string(8)        not null
#  carcass_id       :string(8)        not null
#  pen_id           :string(8)        not null
#

class HideCarcassSample < ActiveRecord::Base
  attr_accessible :sample_date, :lot_id, :carcass_plant_id, :hide_id, :carcass_id, :pen_id
end

