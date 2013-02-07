class PagesController < ApplicationController

  before_filter :authticate, :except => [:about, :comingsoon, :gettingstarted, :howtouse, :faq, :contact, :pricing, :team, :press, :create, :register, :index,:show]

  def index
  end
  
  def about  
  end
  
  def comingsoon
  end
  
  def gettingstarted
  end
  
  def howtouse
  end
  
  def faq
  end
  
  def contact
  end
  
  def pricing
  end
  
  def team
  end
  
  def press
  end
  
end
