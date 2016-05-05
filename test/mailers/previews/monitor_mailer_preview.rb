# Preview all emails at http://localhost:3000/rails/mailers/monitor_mailer
class MonitorMailerPreview < ActionMailer::Preview
  def scraper_mail_preview
    MonitorMailer.scraper_mail
  end
end
