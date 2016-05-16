class LecturersController < ApplicationController
  def index
    @lecturers = if params[:search]
                   Lecturer.fuzzy_search(name: params[:search])
                 else
                   Lecturer.all
                 end

    @lecturers = @lecturers.order(name: :asc)
  end

  def show
    @lecturer = Lecturer.find(params[:id])
  end
end
