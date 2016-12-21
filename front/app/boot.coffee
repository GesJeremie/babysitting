#--------------------------------------------------------------------------
# Boot
#--------------------------------------------------------------------------
#
# It's the right place to put some code to execute globally like
# the init of jQuery plugins, etc.
##

# Include dependencies
Noty = require 'initializers/noty'
FlashMessages = require 'initializers/flash-messages'
Autosize = require 'initializers/autosize'
Confirm = require 'initializers/confirm'

# Init the initializers
(new Noty).init()
(new FlashMessages).init()
(new Autosize).init()
(new Confirm).init()
