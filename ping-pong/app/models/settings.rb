# Settings object from Settingslogic
class Settings < Settingslogic
  source "#{Karafka::App.root}/config/settings.yml"
  namespace Karafka::App.env
end
