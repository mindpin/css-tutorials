class StoriesController < ApplicationController
  def show
    id = params[:id]
    @data = YAML.load_file("lib/stories-data/#{id}.yaml")
  end
end
