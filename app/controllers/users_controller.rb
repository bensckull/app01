class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def edit
  end

  def lien_cv
    @file = params[:file_name]
    @file = "public/uploads/"+@file
    send_file(@file, :type=>"application/pdf")
    #send_file Rails.root.join('private', "public/uploads/"+params[:format]), :type=>"application/pdf", :x_sendfile=>true
    #send_file "#{Rails.root}/public/uploads/"+params[:format], :type=>"application/pdf"
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile mis à jour"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save

      if(params[:user][:file] != nil && params[:user][:file] != "")
        uploaded_io = params[:user][:file]

        File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
          file.write(uploaded_io.read)
          params[:user][:PDF_Cv] = uploaded_io.original_filename
          @user.update_attributes(user_params)
        end
      end

      sign_in @user
      flash[:success] = "Bienvenue sur le site Web App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def stats
    @nb_users = User.count
    @nb_true_user = User.where(livres: true)
    @nb_true = @nb_true_user.count
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :date_naissance, :nb_films, 
                                   :m_visio_films, :nb_livres, :livres, :PDF_Cv)
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def upload_file

    end
end