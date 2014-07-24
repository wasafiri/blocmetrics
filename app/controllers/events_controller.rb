class EventsController < ActionController::Base
  respond_to :json
  before_filter :cors_set_headers
  after_filter :cors_set_access_control_headers

  def options
    render(:text => '', :content_type => 'text/plain')
  end

  def create
    @app = App.find(event_params[:app_id])
    raise ActiveRecord::RecordNotFound if @app.blank?
    @event = @app.events.build(event_params)
    if @event.save
      render json: @event
    else
      render json: @event.errors
    end
  end

  private

  def event_params
    params.require(:event).permit(:app_id, :ip_address, :web_property_id, :action, :updated_at, :created_at)
  end

  def cors_set_headers
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
      headers['Access-Control-Max-Age'] = '86400'
      render(:text => '', :content_type => 'text/plain') and return
    end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
    headers['Access-Control-Max-Age'] = "86400"
  end
end
