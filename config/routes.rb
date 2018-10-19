Rails.application.routes.draw do
 devise_for :users
 root 'tweets#index'                        #ルートパスの指定
 # get   'tweets'      =>  'tweets#index'     #ツイート一覧画面 tweetsにアクセスした時にtweetsコントローラのindexアクションが動く
 # get   'tweets/new'  =>  'tweets#new'       #ツイート投稿画面
 # post  'tweets'      =>  'tweets#create'
 # get   'users/:id'   =>  'users#show'       #ツイート投稿機能
 # delete  'tweets/:id'  => 'tweets#destroy'
 # patch   'tweets/:id'  => 'tweets#update'   #ツイートの更新機能
 # get   'tweets/:id/edit'  => 'tweets#edit'                                            #Mypageへのルーティング #get     '/コントローラ名/:id' => 'コントローラ名#show'
 # get   'tweets/:id'  =>  'tweets#show'      #ここでのidは、書き込みする事を指定したツイートのid
 #   'comments/:id'  =>  'comments#show'
 
  resources :tweets do                    #tweets_controllerに対してのresourcesメソッド
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]       #users_controllerに対してのresourcesメソッド
end