class PagesController < ApplicationController
  layout "standard"
  
  def index
  end
  
  def legal
  end
  
  def credits
    @contributors = User.find(:all, :conditions => ["contributor = ?", true])
  end

  def termsofuse
  end

  def privacypolicy
  end

end
