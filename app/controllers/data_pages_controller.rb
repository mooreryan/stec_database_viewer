class DataPagesController < ApplicationController
  def view
  end

  def add
  end

  def edit
  end

  def samples # tested in data_pages_spec.rb
    @fecal = Sample.select('*').joins('inner join fecal_samples on samples.sample_id = fecal_samples.fecal_id')
    @hide = Sample.select('*').joins('inner join hide_carcass_samples on samples.sample_id = hide_carcass_samples.hide_id')
    @carcass = Sample.select('*').joins('inner join hide_carcass_samples on samples.sample_id = hide_carcass_samples.carcass_id')

    @filtered_fecal   = @fecal.search(params[:search])
    @filtered_hide    = @hide.search(params[:search])
    @filtered_carcass = @carcass.search(params[:search])
  end

  def sampling_info
    @crews = 
      Crew.select('crews.crew_id, crews.person_id, people.name').
      joins('inner join people on crews.person_id = people.person_id').
      map { |crew_record| [crew_record.crew_id, crew_record.name] }. # -> [ [crew_num, person_name] , [..., ...], ... ]
      group_by { |crew_person_list| crew_person_list[0] }. # grouping by crew
      map { |key, val| val.map { |person| person[1] } }. # -> [ [name1, name2,...], [name3, name4,...], ... ]
      map { |list| list.join ", " } # -> ["name1, name2,...", "name3, name4,...", ...]
  end

  def fecal_samples
  end

  def hide_samples
  end

  def people
  end
end
