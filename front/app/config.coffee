#--------------------------------------------------------------------------
# Config
#--------------------------------------------------------------------------
#
# Sometimes you need to put some configuration variables for your project,
# here it's the right place for that !
#
# Config = require 'config'
# console.log Config.app.name
##

module.exports =

  keenio:
    dev:
      projectId: "57aeaf313831444167e1fa35"
      writeKey: "b90d7934bb1d121351a8cad5ec0b4687a81f86e47186d2812cf531f3e7bb62025622b50482fa18d03565d7815f0eaebab74a444af9b7dbfa94fc7621eec1e8ef786da80339a9b642402c893a52b8967a5b7241df69783d2c782ed66f82f1cc47"
      readKey: "410e0b58f9d6c3371cd296341701dc9758bd8b47d9def44aff868ba6cfd54dfe394b8eb113a55c8dc4df2042975da73e7bcc9e397e1e8ca48f75607fd2caa712359db81d2cc304029fc6b20cc34795344551caf82419a8744bc650f9a8b910ac"
    prod:
      projectId: "57aeaf403831444166bd17a4"
      writeKey: "154376d19d2ec08fcdffb865e0359b49e137c60b117ae1f10dcf842490c9ebe3ca224029d360535d9ede8ad547e2809ed4f2bb5388c015767ca0c0f9242a64b3074233588b6d2b8ecdbb480e404f68a2bb5d83c45144be4d2d0cdcd3e3bdcf7f"
      readKey: "da66e4ebebd9520fcfb415a842c81e3cfc8df1686c1123ed640895a3a948f8544c6ca226e5cc252b22f7047768380d41793b9a01c0aa47592fae3c7db83797e4f30ade0adbaae72c3e584ab7619e8c5b472edefec7458d8f368ac348ca342551"

  ##
  # Return current environment
  ##
  env: () =>
    $app = $('#app-config[data-environment]')

    if $app.length
      return $app.data('environment')

    console.log("[WARNING] Environment not specified, fallback to prod")
    return 'prod'
