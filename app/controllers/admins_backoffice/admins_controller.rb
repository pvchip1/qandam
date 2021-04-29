class AdminsBackoffice::AdminsController <  AdminsBackofficeController
  before_action :set_id, only: %i[edit update destroy ]
  before_action :check_password_blank, only: [:update]

  def index
    @admins = Admin.all
  end
  
  def new
    @admin = Admin.new
  end
  
  def create
    
    @admin = Admin.new(set_params_admin)

    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: 'Created Sucess!'
    else
      render :index
    end
  end
  

  def edit
  end
  
  def update
    #require key "admin" comming from form
    if @admin.update(set_params_admin)
      redirect_to edit_admins_backoffice_admin_path, notice: 'Updated Sucess!'
    else
      render :edit
    end
    # if @admin.errors.any?
    #   puts admin.errors.full_messages
    # end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: 'Deleted Sucess!'
    else
      render :index
    end
  end
  

  private
  
  def check_password_blank
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
  
  def set_id
    @admin = Admin.find(params[:id])
  end
  
  def set_params_admin
    params_admin = params.require(:admin).permit( :email, :password, :password_confirmation )
  end
    
end
