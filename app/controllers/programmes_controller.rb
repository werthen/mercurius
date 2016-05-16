class ProgrammesController < ApplicationController
  def index
    @programmes = if params[:search]
                    Programme.fuzzy_search(name: params[:search])
                  else
                    Programme.all
                  end
  end

  def show
  end
end
