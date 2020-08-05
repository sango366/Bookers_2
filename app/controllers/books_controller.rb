class BooksController < ApplicationController
 before_action :authenticate_user! #ログインしいないユーザーにはログインしてもらう
  def index
  	@book = Book.new
  	@books = Book.all
  	@user = User.find(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id #子には、親のIDを付けなければいけない。
    if @book.save
    redirect_to book_path(@book.id), notice: 'successfully' #books_pathだと index 一覧に飛ぶ
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def new
  end

  def show
  	@book = Book.new #_listに空のインスタンスを渡す。このときに、@book = Book.newとすると、NEWBookの欄に投稿したものが表示される。
    #_listに渡す、@bookインスタンスの中にBook.find(params[:id])を入れていたため。
    @book = Book.find(params[:id])#せっかく作ったので、空のインスタンスの中にBookの情報を入れる。
    @user = @book.user #インスタンス変数.カラム名でデータを参照できる。そして、
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id != current_user.id #情報を取ってくる時は、インスタンスに.でつなぐ。user_idだと情報を受け取れない。
    redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])  #editで送るやつのデータを勝手にやってくれる。
    if @book.update(book_params)   #ifでもし、アップロードできたら、その詳細画面にいくように
      flash[:edit_ok] = 'You have updated book successfully.' #リダイレクトの前に置かないと、置いてれる。島に。コードは上から読み込まれる。上で飛んでしまうとダメ。
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :profile_image)
  end
  def book_params
      params.require(:book).permit(:title, :body)
  end
end
