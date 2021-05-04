class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_id, only: %i[edit update destroy]
  before_action :set_subject, only: %i[ edit update ]
  def index
    @questions = Question.all
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.create(set_params)
    @question.save!
  end
  
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    if @question.update(set_params)
      redirect_to admins_backoffice_questions_path, notice: 'Update Success'
    end
  end
  
  def destroy
    if set_id.any?
      if @question.destroy
        redirect_to admins_backoffice_questions_path, notice: 'Deleted Success'
      else
        redirect_to admins_backoffice_questions_path, notice: 'Not deleted'
      end
    end
  end
  
  private 
  
  def set_params
    params_question = params.require(:question).permit(:description)
  end
  
  def set_id
    @question = Question.find(params[:id])
  end

  def set_subject
    @question = Subject.find(params[:id])
  end
  
end
