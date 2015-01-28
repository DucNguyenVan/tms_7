class CoursesController < ApplicationController
  def new
  	@course = Course.new
  end

  def show
  	@course = Course.find(params[:id])
  end

  def create
  	@course = Course.new(course_params)
  	if @course.save
  		flash[:success] = 'Added new course.'
  		redirect_to @course
  		return
  	else
  		render 'new'
  	end
  end

  def index
  	@courses = Course.paginate(page: params[:page])
  end

  def destroy
  	Course.find(params[:id]).destroy
  	flash[:success] = 'Deleted course.'
  	redirect_to courses_url
  end

private 
  	def course_params
  		params.require(:course).permit(:name)
  	end
end
