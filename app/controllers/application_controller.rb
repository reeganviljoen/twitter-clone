class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private 
  def extract_mentions_and_tags
    params[:mentions_attributes] = {}
    params[:tags_attributes] = {}

    words = params[:content].gsub('<div>', '').gsub('</div>', '').split(' ')
    words.each_with_index do |word, index|
      if word[0] == '@'
        mention = "<a href='#'>#{word}</a>"

        params[:content].gsub!(word, mention)
        params[:mentions_attributes][index.to_s] = {user_name: word.sub('@', '')}
      end

      if word[0] == '#'
        tag = "<a href='#'>#{word}</a>"

        params[:content].gsub!(word, tag)
        params[:tags_attributes][index.to_s] = {body: word.sub('#', '')}
      end
    end
  end 
end
