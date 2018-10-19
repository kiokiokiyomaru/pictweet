class TweetsController < ApplicationController

    before_action :move_to_index, except: [:index, :show] #非ログインユーザーの書き込み画面侵入排除 ※クラスの決め事
    # (indexアクションを除き)すべてのアクションが実行される前には必ずmove_to_indexアクションが実行される

  def index  #全投稿内容を表示
    # @tweets = Tweet.all.order("id DESC")
    # @tweets = Tweet.order("id DESC").page(params[:page]).per(5)
    # @tweets = Tweet.order("created_at DESC").page(params[:page]).per(5)  #5ページづつ昇順で表示 ※ハッシュのPageキーを利用
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC") #Kaminariのpageメソッドincludeメソッドで計算量を減らす 2nからnに
  end

  def new
    #新規投稿画面の表示
  end     #モデルを利用した情報の表示などは行わないのでこれでOK

  # def create  #新規投稿データの保存
  #   Tweet.create(name: params[:name], image: params[:image], text: params[:text] #テーブルにレコードを新規作成 paramsメソッドを使用し値にキーをつけ付ける
  # end
  #→→→セキュリティの為、ストロングパラメーターに変更(指定したキーを持つパラメーターのみを受け取るようにする)
  def create
    # Tweet.create(tweet_params)  #モデルクラスTweetのcreatメソッドをハッシュparamsの戻り値を引数にして実行
    # Tweet.create(name: tweet_params[:name], image: tweet_params[:image], text: tweet_params[:text])
    # Tweet.create(name: tweet_params[:name], image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id) #paramsから持ってきたデータにuser_idを付け足し
     Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id) #クラス名.メソッド名(カラム1: 投稿情報1, カラム2:投稿新情報2。。。)
  end

  def destroy
    tweet = Tweet.find(params[:id])      #tweetsテーブルから指定したidの情報をtweetに代入
    tweet.destroy if tweet.user_id == current_user.id  #変数tweetをActiveRecordメソッドdestroyで処理条件付きで
  end
  
  def edit
    @tweet = Tweet.find(params[:id])  #編集したいレコード(tweesテーブルのidのレコード)を@tweetに代入し、編集画面で利用できるように
  end
  
  def update #edit画面でsent押下で行われるアクション
    # Tweet.update(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id) 
    # tweet = Tweet.find(params[:id])  
    # tweet.update(tweet_params) if tweet.user_id == current_user.id#ユーザーidを更新する必要がないので
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)  
    end
    
  end
  
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)   #@comments = @tweet.comments でも見た目の挙動は変わらないが処理量が多い
  end

  # ivatprivate  
  # private  #プライベートメソッド
  #   params.permit(:name, :image, :text)
 private    #プライベートメソッド：同じクラスの内部からのみ呼び出せる＝routesからは呼び出せない※ハッキング阻止の為、ストロングパラメーターにしている「permit」
  def tweet_params  
    # params.permit(:name, :image, :text,)  #指定した3つの要素に限り、ハッシュparamsに格納する
    params.permit(:image, :text)
  end

  def move_to_index          #非ログインユーザーの
    redirect_to action: :index unless user_signed_in?  #ログインしていないユーザーは強制的にindexアクションに遷移する
  end
end
