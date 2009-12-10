class FlagsController < ApplicationController
  def new
    @flag = Flag.new
  end

  def create
    @flag = Flag.new(params[:flag])
    @flag.flaggable_id = params[:id]
    @flag.flaggable_type = params[:type]
    
    respond_to do |format|
      if @flag.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to :back }
        format.js { render :text => 'true' }
      else
        format.html { render :action => "new" }
        format.js { render :text => 'false' }
      end
    end
  end
end
