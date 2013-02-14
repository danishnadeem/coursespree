module UsersHelper
  
  def userbtn_text
    if controller.action_name == "register"
      "Sign Up"
    elsif controller.action_name == "edit"
      "Update"
    else
      "Submit"
    end
  end
  def add_user_as_tutor(user_id)
    link_to 'Add user as Tutor', :action => 'addtutor', :controller => "tutors", :from_add_user_as_tutor => "true", :user_id => user_id
  end
end
