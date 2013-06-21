# == Schema Information
#
# Table name: sampling_infos
#
#  sample_date  :date             not null, primary key
#  pen_id       :string(8)        not null
#  head_per_pen :integer
#  crew_id      :integer          not null
#  observations :text
#  hides_n      :string(20)
#  carcass_n    :string(20)
#  feces_n      :string(20)
#

class SamplingInfo < ActiveRecord::Base
  attr_accessible :sample_date, :pen_id, :head_per_pen, :crew_id, :observations, :hides_n, :carcass_n, :feces_n
end
