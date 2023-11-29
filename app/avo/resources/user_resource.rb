class UserResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :email, as: :text
  field :invitation_token, as: :text
  field :invitation_created_at, as: :date_time
  field :invitation_sent_at, as: :date_time
  field :invitation_accepted_at, as: :date_time
  field :admin, as: :boolean
  field :invited_by, as: :belongs_to
end
