class ImportsController < ApplicationController
  before_action :set_import, only: %i[show edit update destroy]

  # GET /imports
  def index
    @imports = Import.order(updated_at: :desc)
  end

  # GET /imports/1
  def show; end

  # GET /imports/new
  def new
    @import = Import.new
  end

  # GET /imports/1/edit
  def edit; end

  # POST /imports
  def create
    @import = Import.new(status: 0)

    if @import.save
      ImportPostsJob.perform_later(@import.id)
      redirect_to imports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /imports/1
  def update
    if @import.update(import_params)
      @import.broadcast_replace_later_to 'imports', partial: 'imports/import'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /imports/1
  def destroy
    @import.destroy
    redirect_to imports_url, notice: 'Import was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import
    @import = Import.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def import_params
    params.require(:import).permit(:status)
  end
end
