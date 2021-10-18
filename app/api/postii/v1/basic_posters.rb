module Postii::V1
  class BasicPosters < Grape::API
    version 'v1', using: :path
    format :json

    resource :basic_posters do
      desc 'Returns a list of quests of this a specific basic poster.'
      params do
        requires :id, type: String
      end
      get '/:id/quests' do
        basic_poster = BasicPoster.find(params[:id])
        quests = basic_poster.quests
        present quests
      end

      desc 'Creates a new Quest for a BasicPoster'
      params do
        requires :id, type: String
        requires :quest_type, type: String
        requires :mandatory, type: Boolean
        requires :question, type: String
        optional :answer, type: String
      end
      post '/:id/quests' do
        basic_poster = BasicPoster.find(params[:id])
        quest = basic_poster.quests.create(
          quest_type: params[:quest_type],
          mandatory: params[:mandatory],
          question: params[:question],
          answer: params[:answer]
        )
        present quest
      end

      desc 'Returns the result to the query of BasicPoster'
      params do
        optional :poster_id, type: String
        optional :title, type: String
        exactly_one_of :poster_id, :title
      end
      post '/query' do
        if params[:poster_id].present?
          basic_poster = BasicPoster.find_by_poster_id(params[:poster_id])
          present basic_poster
        end

        if params[:title].present?
          basic_posters = BasicPoster.where('title LIKE ?', "%#{params[:title]}%")
          present basic_posters
        end
      end
    end
  end
end
