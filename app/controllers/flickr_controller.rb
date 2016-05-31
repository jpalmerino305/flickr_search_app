require 'will_paginate/array'
class FlickrController < ApplicationController

	PER_PAGE = 50

	def search
		flickr = Flickr.new(:key => ENV["FLICKR_API_KEY"], :secret => ENV["FLICKR_SECRET_KEY"])
		if params[:search_term]
			@search_term = params[:search_term]
			photos = flickr.photos.search(
				text:     @search_term,
				page:     params[:page] || 1,
				per_page: PER_PAGE
			)
			current_page = params[:page] || 1
			@photo_result = WillPaginate::Collection.create(photos.page, PER_PAGE, photos.total) do |pager|
				pager.replace photos
			end
		else
			redirect_to :action => "index"
		end
	end

end