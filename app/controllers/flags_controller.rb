class FlagsController < ApplicationController
  def new
    @flag = Flag.new
  end

  def create
    @flag = Flag.new(params[:flag])
    @flag.flaggable_id = params[:id]
    respond_to do |format|
      if @flag.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to :back }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
