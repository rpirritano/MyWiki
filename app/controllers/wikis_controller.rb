class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :edit, :update]



  def index
    #@wikis = Wiki.all
    @wikis = policy_scope(Wiki)
    if current_user.present?
      authorize @wikis
    else
      skip_authorization
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
    else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end
   
  def current_user_admin?
    current_user.admin?
  end
  
  helper_method :current_user_admin?

  def current_user_premium?
    current_user.premium?
  end
  
  helper_method :current_user_premium?


private

def set_wiki
  @wiki = Wiki.find(params[:id])
end

def wiki_params
  params.require(:wiki).permit(:title, :body, :private)
end

end