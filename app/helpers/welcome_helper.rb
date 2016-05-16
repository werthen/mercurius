module WelcomeHelper
  def thing
    %w(🦄 🐧 🐳 🐕 🐈 🐩 🐪).sample
  end

  def love
    %w(💓 💕 💖 💗 💘 💙 💚 💛 💜 💝 💞 ♡).sample
  end

  def locales
    a_l = I18n.available_locales.map do |l|
      # no_turbolink to make I18n.js work
      link_to l, url_for(locale: l), data: { no_turbolink: true }
    end
    sanitize(a_l.join(' | '), attributes: %w(href data-no-turbolink))
  end
end
