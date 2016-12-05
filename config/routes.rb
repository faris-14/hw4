Rails.application.routes.draw do
    get '/', to: 'application#index'
    post '/search', to: 'application#search'
    get '/tweets', to: 'application#tweets'
end
