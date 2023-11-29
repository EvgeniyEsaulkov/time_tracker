class ProjectResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :name, as: :text
  field :description, as: :trix
end
