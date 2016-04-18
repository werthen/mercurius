class CoursesController < ApplicationController
  def index
    @courses = if params[:search]
                 Course.fuzzy_search(name: params[:search])
               else
                 Course.all
               end

    @page = (params[:page] || 1).to_i

    @courses = @courses.page(@page)
    not_found if @courses.out_of_bounds?
  end

  def show
    @course = Course.find(params[:id])
  end
end
