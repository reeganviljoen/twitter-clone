class TweetsController < ApplicationController
  before_action :extract_tweet_mentions_and_tags, only: :create


  def index 
    @tweets = Tweet.where(user_id: current_user.id).created_at_desc
  end
  
  def new 
    @tweet = current_user.tweets.new
  end
  
  def create     
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to new_tweet_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    respond_to do |format|
      begin
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        format.html {redirect_to root_path}
      rescue ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordNotFound
        format.html{ redirect_to root_path, status: :unprocessable_entity }
      end
      format.turbo_stream
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :tweet_type, tags_attributes: :body, mentions_attributes: :user_name)
  end

  def extract_tweet_mentions_and_tags
    params[:tweet][:mentions_attributes] = {}
    params[:tweet][:tags_attributes] = {}

    words = params[:tweet][:content].gsub('<div>', '').gsub('</div>', '').split(' ')
    words.each_with_index do |word, index|
      if word[0] == '@'
        mention = "<a href='#'>#{word}</a>"

        params[:tweet][:content].gsub!(word, mention)
        params[:tweet][:mentions_attributes][index.to_s] = {user_name: word.sub('@', '')}
      end

      if word[0] == '#'
        tag = "<a href='#'>#{word}</a>"

        params[:tweet][:content].gsub!(word, tag)
        params[:tweet][:tags_attributes][index.to_s] = {body: word.sub('#', '')}
      end
    end
  end 
end