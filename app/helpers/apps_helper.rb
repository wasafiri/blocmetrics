module AppsHelper
	def pretty_up_time(app)
		app.created_at.to_time.strftime('%B %d, %Y')
	end
end
