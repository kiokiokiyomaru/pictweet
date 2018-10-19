class UsersController < ApplicationController
  def show
    # @nickname = current_user.nickname #現在ログインしているユーザーのニックネーム
    #         # @tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC") #whereはActiveRecordメソッドなのでテーブル間をまたいで処理できる
    # @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC") #Usersクラスのインスタンスメソッド@tweetsの定義。ログインユーザーのtweetsテーブルを5ページづつ
    #         # @tweetsはTweetsクラスのインスタンス変数とはまた別
    
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
end
