class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:private]
end
