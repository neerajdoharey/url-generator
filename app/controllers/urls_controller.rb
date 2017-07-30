class UrlsController < ApplicationController
  before_action :find_awesome_url , only: [:show, :generated_url]
  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.url_cleaner
    puts @url.new_url?
    if @url.new_url?
      if @url.save
        flash[:success] = "A short link for this URL generated"
        redirect_to  generated_url_path(:awesome_url => @url.awesome_url)
      else
        render new_url_path
      end
    else
      flash[:danger] = "A short link for this URL is already in our database"
      redirect_to  generated_url_path(:awesome_url => @url.awesome_url)
    end
  end

  def show
    redirect_to("http://#{@url.real_url}")
  end

  def generated_url

  end
  private
  def url_params
    params.require(:url).permit(:real_url)
  end

  def find_awesome_url
    @url = Url.find_by_awesome_url(params[:awesome_url])
  end
end
