class DataPagesController < ApplicationController
  def view
  end

  def add
  end

  def edit
  end

  def samples
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
