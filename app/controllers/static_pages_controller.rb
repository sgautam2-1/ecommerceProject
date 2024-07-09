class StaticPagesController < ApplicationController
    def update
      @static_page = StaticPage.find(params[:id])
      if @static_page.update(static_page_params)
        redirect_to admin_static_page_path(@static_page), notice: "Static page updated successfully."
      else
        render :edit
      end
    end
  
    private
  
    def static_page_params
      params.require(:static_page).permit(:title, :content)
    end
  end