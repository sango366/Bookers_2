class UsersController < ApplicationController
  before_action :authenticate_user! #ログインしいないユーザーにはログインしてもらう
  def index
  	@book = Book.new #bookの情報、投稿データを。これは自分の投稿したもの
  	@users = User.all #userの情報、他の人のも
    @user = current_user #自分のログイン情報かな
  end

  #このクリエイトいらない疑惑
  # def create
  #     book = Book.new(book_params) #画面に表示されるものは、＠をつけましょう。しかし、クリエイトアクションには、＠を付けない。エラー処理は、画面に表示されるため、＠つける。
  #     book.save
  #     redirect_to books_path,notice: 'successfully' #redirectの引数として書く書き方であり、単独では仕えない。
  # end

  def show
  	@book = Book.new
  	@user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user =User.find(params[:id])    #ここで、@userインスタンスに
    if @user.update(user_params)
    redirect_to user_path(@user.id),notice: 'You have updated user successfully.' #この書き方は、リダイレクトの引数として書く場合のみ、適応される。通常は、flashを使ったほうが無難。
    else
    render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

end