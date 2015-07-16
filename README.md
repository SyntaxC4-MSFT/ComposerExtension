![](https://img.shields.io/badge/platform-Azure-00abec.svg?style=flat-square)
![](https://img.shields.io/badge/PHP-5.4%2C%205.5%2C%205.6-4F5B93.svg?style=flat-square)
![](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)

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
| APPSETTING_COMMAND  | %XDT_EXTENSIONPATH%\Hooks\deploy.cmd  | Deployment Hook Command.                 |
| PATH                | %PATH%;%XDT_EXTENSIONPATH%\Commands;%APPDATA%\Composer\vendor\bin   | Overwrites the Path. Last Extension Wins |
| COMPOSER_ARGS       | --prefer-dist --no-dev --optimize-autoloader --no-progress  |  Command line arguments for composer during deploy.cmd execution |

