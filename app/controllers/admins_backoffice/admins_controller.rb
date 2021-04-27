class AdminsBackoffice::AdminsController <  AdminsBackofficeController

  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update

    if params[:password].blank? && params[:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end

    @admin = Admin.find(params[:id])
    #require key "admin" comming from form
     params_admin = params.require(:admin).permit( :email, :password, :password_confirmation )

    if @admin.update(params_admin)
      redirect_to edit_admins_backoffice_admin_path, notice: 'Sucess!'
    else
      render :edit
    end
    # if @admin.errors.any?
    #   puts admin.errors.full_messages
    # end
  end
end
