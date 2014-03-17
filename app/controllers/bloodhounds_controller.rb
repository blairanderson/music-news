class BloodhoundsController < ApplicationController
  def create
    results = Bloodhound.create(params)
    if results.present?
      render json: results.to_json, status: :ok
    else
      head :unprocessable_entity
    end
  end
end
