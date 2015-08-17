class WebhooksController < ApplicationController
  def create
    if params["ID"]
      WordpressSync.fetch(params["ID"])
      head :ok
    else
      head :fail
    end
  end
end
