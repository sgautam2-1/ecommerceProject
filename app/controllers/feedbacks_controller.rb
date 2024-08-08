class FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show edit update destroy]

  def show
    # @feedback should be set by before_action
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to @feedback, notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to @feedback, notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to feedbacks_url, alert: 'Feedback not found.'
  end

  def feedback_params
    params.require(:feedback).permit(:message, :image)
  end
end
