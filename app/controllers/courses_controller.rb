class CoursesController < ApplicationController
  def new
    @course = Course.new
    @user_course = UserCourse.new 
    @users = User.all
  end

  def show
    @course = Course.find params[:id]
    @user_courses = UserCourse.find_by(course_id: params[:id])
    @users = User.find_by(id: @user_courses.user_id)
  end

  def create
    @course = Course.new course_params
    @user_course = UserCourse.new user_course_params
    @user_course.save
    if @course.save
      flash[:success] = "Added new course."
      #update course_id into UserCourse table
      @user_course.update_attributes(course_id: @course.id)
      # unless @user_course.save
      #   flash[:danger] = "Failed to create UserCourse item"
      # end
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
    params.require(:course).permit(:name) #:course la symbol cua form_for
  end

  def user_course_params
    params.require(:user).permit(:user_id) #:user la symbol cua collection_select
  end
end
