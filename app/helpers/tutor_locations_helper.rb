module TutorLocationsHelper
  def univs_and_ids
    University.all.map{|u| [u.name, u.id]}
  end
end
