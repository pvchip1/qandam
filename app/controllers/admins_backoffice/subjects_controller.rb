class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject_id, only: %i[edit update destroy]
  
  def index
    @subjects = Subject.all.order(:description).page(params[:page]).per(15)
    @subject_count = Subject.all.count
  end

  def new
    @subject = Subject.new
  end
  
  def create
    @subject = Subject.new(set_params)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: 'Create success'
    else
      redirect_to admins_backoffice_subjects_path
    end
  end
  
  def edit
  end

  def update
    if @subject.update(set_params)
      redirect_to admins_backoffice_subjects_path, notice: 'Update Success'
    else
      render :edit
    end
  end
  
  def show
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: 'Deleted with success'
    else
      redirect_to '#', notice: 'No deleted'
    end
  end
  
  private

  def set_subject_id
    @subject = Subject.find(params[:id])
  end

  def set_params
    params_subject = params.require(:subject).permit(:description)
  end
end
