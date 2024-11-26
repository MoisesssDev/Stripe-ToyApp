class BatchesController < ApplicationController
  before_action :set_experience, only: [ :new ]
  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    if @batch.save
      redirect_to experience_path(@batch.experience), notice: "Batch was successfully created."
    else
      render :new
    end
  end

  private

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end

  def batch_params
    params.require(:batch).permit(:price, :experience_id)
  end
end
