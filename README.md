# Azure App Service Web App Composer Site Extension

This site extension adds [Composer](http://getcomposer.org) support to Web App to enable dependency management for PHP applications.

## Installation

Follow the instructions outlined in the article [How to enable a Site Extension in Azure App Service Web App](http://blog.syntaxc4.net/post/2015/02/05/how-to-enable-a-site-extension-in-azure-websites.aspx) when selecting an extension look for the list item for [Composer](http://www.siteextensions.net/packages/ComposerExtension/).

## Usage

There are multiple ways to use Composer from Web App.

### Continuous Deployment

This [sample application](https://github.com/SyntaxC4-MSFT/WAWS-Composer) demonstrates the usage of the `composer.json` file in Web App.

* Place a `composer.json` file in the root of your repository
* vendor folder will be created in `d:\home\site\vendor`
* reference to the autoload.php file `require_once "../vendor/autoload.php";`

### Command-Line

* Open the Kudu Debug Console (http://&lt;site-name&gt;.scm.azurewebsites.net/DebugConsole) or Install [KuduExec](https://github.com/projectkudu/kuduexec)
* run composer from the command line `composer selfupdate`

### Timeout configuration

In some cases (especially when attempting to install great amount of packages, [#1](https://github.com/SyntaxC4-MSFT/ComposerExtension/issues/1)) the deployment may timeout and the dependencies won't get loaded correctly by Composer. A simple fix is to add a [deployment configuration](https://github.com/projectkudu/kudu/wiki/Customizing-deployments) (create `.deployment` file) with parameter [**SCM_COMMAND_IDLE_TIMEOUT**](https://github.com/projectkudu/kudu/wiki/Configurable-settings) and set it to bigger number (for example `SCM_COMMAND_IDLE_TIMEOUT=600` where 600 is time out in seconds). The default value in Azure Web Apps for this setting appears to be 400 seconds.

## AppSettings

| Name                | Value                                 |Notes                                     |
|---------------------|---------------------------------------|------------------------------------------|
| APPSETTING_COMMAND  | %XDT_EXTENSIONPATH%\Hooks\deploy.cmd  | Deployment Hook Command. (causes .deployment file not to function [[bug](https://github.com/projectkudu/kudu/issues/1519)])                |
| PATH                | %PATH%;%XDT_EXTENSIONPATH%\Commands   | Overwrites the Path. Last Extension Wins |
| COMPOSER_ARGS       | --prefer-dist --no-dev --optimize-autoloader --no-progress  |  Command line arguments for composer during deploy.cmd execution |
| COMPOSER_VENDOR_DIR | d:\home\site\vendor\                  | Moves the vendor folder out of wwwroot for security purposes.
