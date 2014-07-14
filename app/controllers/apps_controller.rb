class AppsController < ApplicationController

	def index
		@apps = App.all
	end

	def new
	  @app = App.new
	  authorize @app
	end

	def show
		@app = App.find(params[:id])
		authorize @app
	end

	def create
		@app = App.new(app_params)
    authorize @app
		@app.user = current_user
    	if @app.save
			redirect_to app_path(@app), notice: "App was added successfully." and return
		else
			flash[:error] = "Error adding app. Please try again."
			render :new and return
		end
	end

	def edit
		@app = App.find(params[:id])
    authorize @app
		# edit action is responsible for rendering the view
		# update action is responsible for interacting with the model
	end

	def update
		@app = App.find(params[:id])
    authorize @app
		if @app.update_attributes(app_params)
			redirect_to @app and return
		else
			flash[:error] = "Error updating app. Please try again."
			render :edit and return
		end
	end

	def destroy
		@app = App.find(params[:id])
    authorize @app
		if @app.destroy
			flash[:notice] = "The app #{@app.name} was successfully deleted."
			redirect_to apps_path and return
		else
			flash[:error] = "There was an error deleting the app."
		end
	end

	private

	def app_params
		params.require(:app).permit(:name, :desc, :user_id)
		# using strong_parameters here
		# more: http://blog.sensible.io/2013/08/17/strong-parameters-by-example.html
	end
end
