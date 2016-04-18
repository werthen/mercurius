class LecturersController < ApplicationController
  def index
    @lecturers = Lecturer.all.order(name: :asc)
  end

  def show
  end
end
