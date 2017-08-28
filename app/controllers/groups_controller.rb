class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups.all.includes(:products)
  end

  def show
  end

  def new
    @group = current_user.groups.new
  end

  def edit
  end

  def create
    @group = current_user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path,
                                    notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors,
                                                status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path,
                                    notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url,
                                  notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_group
      @group = current_user.groups.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, products_attributes: [:asin, :id,
                                                      :amazon_url, :_destroy])
    end
end
