module TutorLocationsHelper
  def univs_and_ids
    University.all.sort_by { |m| m[:name] }.map{|u| [u.name, u.id]}
  end
  def depts_and_ids
    Department.all.map{|d| [d.name, d.id]}
  end
end
