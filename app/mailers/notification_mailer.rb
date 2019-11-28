class NotificationMailer < ApplicationMailer

  default to: 'admin@passion.io'

  def new_record_created(record_class:, record_id:)
    @record = record_class.constantize.find(record_id)

    subject = "New #{@record.class.name} created"
    body =  "Record with #{@record.id} is created at #{@record.created_at.strftime('%m.%d %H:%M')}"

    mail(subject: subject, body: body)
  end

end
