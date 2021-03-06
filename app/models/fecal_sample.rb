# == Schema Information
#
# Table name: fecal_samples
#
#  sample_date :date             not null
#  pen_id      :string(8)        not null
#  fecal_id    :string(20)       not null, primary key
#

# note that all attributes are accessible by default
# unless you specify the ones you want to be accessible
class FecalSample < ActiveRecord::Base
  attr_accessible :sample_date, :pen_id, :fecal_id
end
