#--------------------------------------------------------------------------
# Brunch Config
#--------------------------------------------------------------------------
#
# It's the brunch configuration for Gotham.
#
# @see https://github.com/brunch/brunch/blob/stable/docs/config.md
#
##
exports.config =

  #--------------------------------------------------------------------------
  # Paths
  #--------------------------------------------------------------------------
  #
  # Contains application paths to key directories. Paths are simple strings.
  #
  # @see https://github.com/brunch/brunch/blob/stable/docs/config.md#paths
  ##
  paths:

    # Path to build directory that would contain output.
    public: '../priv/static'

    # List of all watched paths by brunch.
    watched: ['app', 'vendor', 'core', 'styles']

  #--------------------------------------------------------------------------
  # Files
  #--------------------------------------------------------------------------
  #
  # Configures handling of application files:
  #  - Which compiler would be used on which file
  #  - What name should output file have, etc ...
  #
  # Any paths specified here must be listed in paths.watched as described above,
  # for building.
  #
  # @see https://github.com/brunch/brunch/blob/stable/docs/config.md#files
  ##
  files:

    javascripts:

      joinTo:
        'javascripts/app.js': /^(core|app)/
        'javascripts/vendor.js': /^(vendor|bower_components)/

      order:
        before: []
        after: []

    stylesheets:

      joinTo:
        'stylesheets/vendor.css': /^(vendor|bower_components)/
        'stylesheets/app.css': /^styles\/app/
        'stylesheets/dashboard_admin.css': /^styles\/dashboard_admin/
        'stylesheets/dashboard_user.css': /^styles\/dashboard_user/
        'stylesheets/bordeaux.css': /^styles\/hooks\/tenants\/bordeaux/
        'stylesheets/paris.css': /^styles\/hooks\/tenants\/paris/
        'stylesheets/london.css': /^styles\/hooks\/tenants\/london/

      order:
        before: []
        after: []

    templates:
      joinTo: 'javascripts/app.js'

  plugins:
    sass:
      mode: 'native'

  #--------------------------------------------------------------------------
  # Notifications
  #--------------------------------------------------------------------------
  #
  # Enables or disables notifications of:
  #  - Growl
  #  - Growl for Windows
  #  - terminal-notifier
  #  - libnotify
  #
  #
  # @see https://github.com/brunch/brunch/blob/stable/docs/config.md#files
  ##
  notifications: true

  #--------------------------------------------------------------------------
  # Notifications Title
  #--------------------------------------------------------------------------
  #
  # Sets the title used in notifications
  #
  # @see https://github.com/brunch/brunch/blob/stable/docs/config.md#notificationstitle
  ##
  notificationsTitle: 'Front'
