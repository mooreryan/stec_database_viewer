# == Schema Information
#
# Table name: people
#
#  person_id :integer          not null, primary key
#  name      :string(25)       not null
#

class Person < ActiveRecord::Base
  attr_accessible :person_id, :name
end
