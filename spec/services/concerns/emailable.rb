RSpec.shared_examples 'emailable' do |params|
  it 'received proper record data' do
    allow(NotificationMailer).to receive(:new_record_created).and_call_original

    subject

    record = params[:record_class].last

    expect(NotificationMailer).to have_received(:new_record_created)
      .with(
        record_id: record.id,
        record_class: record.class.name
      )
  end

  it 'sends email regarding' do
    expect { subject }.to change { Sidekiq::Worker.jobs.size }.by(1)
  end
end
