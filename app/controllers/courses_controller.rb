class CoursesController < ApplicationController
  def new
    @course = Course.new
    @users = User.all
  end

  def show
    @course = Course.find params[:id]
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Added new course."
      redirect_to courses_path
      return
    else
      #associate with new.html.erb. without new method above
      render 'new'
    end
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
        flash[:success] = "Updated course."
        redirect_to courses_path
    else
      render 'edit'
    end
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Deleted course."
    redirect_to courses_url
  end

  private 
  def course_params
    params.require(:course).permit(:name)
  end
end
