require 'gettext_i18n_rails/string_interpolate_fix'
repos = [
  FastGettext::TranslationRepository.build('pos', path: 'config/locales', type: :po),
  FastGettext::TranslationRepository.build('yamls', path: 'config/locales', type: :yaml)
]
FastGettext.add_text_domain('combined', type: :chain, chain: repos)
FastGettext.default_available_locales = ['es', 'ca'] #all you want to allow
FastGettext.default_text_domain = 'combined'
FastGettext.locale = 'es'
GettextI18nRails.translations_are_html_safe = true
