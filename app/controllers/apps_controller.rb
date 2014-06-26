class AppsController < ApplicationController

	def index
		@apps = App.all
	end

	def new
		@app = App.new
	end

	def show
		@app = App.find(params[:id])
	end

	def create
		@app = App.new(app_params)
    		if @app.save
			redirect_to app_path(@app), notice: "App was added successfully."
		else
			flash[:error] = "Error adding app. Please try again."
			render :new
		end
	end

	private

	def app_params
		params[:app].permit(:name, :desc)
	end

end
