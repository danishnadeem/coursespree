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
  

end
