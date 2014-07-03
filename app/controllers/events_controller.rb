class EventsController < ActionController::Base
  respond_to :json
  respond_to :html

  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, serializer: EventSerializer
    else
      render json: @event.errors
    end
  end

  private

  def event_params
    params.require(:event).permit(:ip_address, :web_property_id, :action, :updated_at, :created_at)
  end
end
