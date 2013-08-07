require 'gettext_i18n_rails/string_interpolate_fix'
FastGettext.add_text_domain('app', path: 'config/locales', type: :po)
FastGettext.default_available_locales = ['es', 'ca', 'en'] #all you want to allow
FastGettext.default_text_domain = 'app'
FastGettext.locale = 'es'
GettextI18nRails.translations_are_html_safe = true
