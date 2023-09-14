class TaskSerializer < ApplicationSerializer
  attributes :id, :name, :description, :state, :expired_at, :transitions, :image_url
  belongs_to :author
  belongs_to :assignee

  def transitions
    object.state_transitions.map do |transition|
      {
        event: transition.event,
        from: transition.from,
        to: transition.to,
      }
    end
  end

  def image_url
    object.image.attached? ? AttachmentsService.file_url(object.image) : nil
  end
end
