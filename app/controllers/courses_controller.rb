class CoursesController < ApplicationController
  def index
    @courses = if params[:search]
                 Course.fuzzy_search(name: params[:search])
               else
                 Course.first(50)
               end
  end

  def show
    @course = Course.find(params[:id])
  end
end
