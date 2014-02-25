class SubmissionSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :body,
              :user_id,
              :created_at,
              :updated_at,
              :twitter,
              :email,
              :view_count,
              :songs_count
              
  has_many :songs
end
