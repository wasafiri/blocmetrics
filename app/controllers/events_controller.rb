class EventsController < ActionController::Base
  respond_to :json

  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event
    else
      render json: @event.errors
    end
  end

  private

  def event_params
    params.require(:event).permit(:ip_address, :web_property_id, :action, :updated_at, :created_at)
  end
end
