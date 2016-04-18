class LecturersController < ApplicationController
  def index
    @lecturers = Lecturer.all
  end

  def show
  end
end
