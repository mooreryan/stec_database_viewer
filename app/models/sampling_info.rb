# == Schema Information
#
# Table name: sampling_infos
#
#  sample_date  :date             not null, primary key
#  pen_id       :string(8)        not null
#  head_per_pen :integer          not null
#  observations :text
#  crew         :text
#

class SamplingInfo < ActiveRecord::Base
  attr_accessible :sample_date, :pen_id, :head_per_pen, :crew_id, :observations, :hides_n, :carcass_n, :feces_n
end
