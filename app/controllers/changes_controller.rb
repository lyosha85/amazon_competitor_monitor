class ChangesController < ApplicationController
  before_action :set_group, only: [:index]

  def index
    @date = params[:date].to_date
    @changes = Changes.in_date(@group, @date)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
