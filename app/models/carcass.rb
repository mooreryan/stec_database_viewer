# == Schema Information
#
# Table name: carcasses
#
#  carcass_plant_id :string(8)        not null, primary key
#  hide_lab_id      :string(8)        not null
#  carcass_lab_id   :string(8)        not null
#

class Carcass < ActiveRecord::Base
end
