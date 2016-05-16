module WelcomeHelper
  def thing
    %w(🦄 🐧 🐳 🐕 🐈 🐩 🐪).sample
  end

  def love
    %w(💓 💕 💖 💗 💘 💙 💚 💛 💜 💝 💞 ♡).sample
  end

  def locales
    sanitize I18n.available_locales.map { |l| link_to l, url_for(locale: l) }.join(' | ')
  end
end
