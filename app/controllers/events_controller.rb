class EventsController < ActionController::Base
  respond_to :json
  before_filter :cors_set_headers
  after_filter :cors_set_access_control_headers

  def options
    render(:text => '', :content_type => 'text/plain')
  end

  def create
    @app = App.find(event_params[:app_id])
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found if !@app
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
      common_cors_headers
      render(:text => '', :content_type => 'text/plain') and return
    end
  end

  def cors_set_access_control_headers
    common_cors_headers
  end

  def common_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
    headers['Access-Control-Max-Age'] = "86400"
  end

  def not_found
    respond_to do |format|
      format.html { render :file => File.join(Rails.root, 'public', '404.html') }
      format.json { render :text => '{"error": "App not found."}' }
    end
  end
end
