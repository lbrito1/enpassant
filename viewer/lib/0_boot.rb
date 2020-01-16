puts
puts "Booting..."

require 'json'
require 'byebug'
require 'awesome_print'
require 'i18n'
require 'active_support'
require 'active_support/inflector'

I18n.config.enforce_available_locales = true
I18n.available_locales = ["pt-BR"]
I18n.default_locale = "pt-BR"

use_helper Nanoc::Helpers::LinkTo
use_helper Nanoc::Helpers::Rendering
