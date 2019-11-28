module Emailable
  extend ActiveSupport::Concern

  def send_notification_email(record)
    NotificationMailer
      .new_record_created(record_id: record.id, record_class: record.class.name)
      .deliver_later
  end
end
