# == Schema Information
#
# Table name: samples
#
#  sample_id         :string(8)        not null, primary key
#  sample_type       :string(25)       not null
#  cryobox_num       :integer          not null
#  cryobox_location  :integer          not null
#  barcode_id        :string(20)
#  processing_status :string(25)       not null
#  serotype          :string(10)
#  path_to_sequence  :string(255)
#

class Sample < ActiveRecord::Base
  
end
