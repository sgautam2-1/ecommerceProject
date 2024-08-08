class StaticPagesController < ApplicationController
  def about
    @static_page = StaticPage.find_by(slug: "about")
    flash[:notice] =
      "We are committed to protecting your rights and preserving your privacy. Our goal is to ensure sustainable development in all our operations."
  end

  def contact
    @static_page = StaticPage.find_by(slug: "contact")
    flash[:notice] =
      "We are committed to protecting your rights and preserving your privacy. Our goal is to ensure sustainable development in all our operations."
  end
end
