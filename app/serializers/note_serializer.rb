class NoteSerializer < ActiveModel::Serializer
  belongs_to :user_id
  attributes :id, :title, :content, :user_id
end
