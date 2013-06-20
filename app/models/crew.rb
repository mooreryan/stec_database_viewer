# == Schema Information
#
# Table name: crews
#
#  crew_id   :integer          not null, primary key
#  person_id :integer          not null
#

class Crew < ActiveRecord::Base
  attr_accessible :crew_id, :person_id

end
