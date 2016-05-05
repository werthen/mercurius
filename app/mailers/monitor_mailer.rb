class MonitorMailer < ApplicationMailer
  default from: 'from@example.com'
  
  def scraper_mail
    mail to: 'werthenlorin@gmail.com', subject: 'Testing'
  end
end
