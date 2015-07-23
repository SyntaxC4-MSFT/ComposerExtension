# Install Composer

cd Commands

IF EXIST composer.phar (
  rm -f composer.phar
)

IF NOT EXIST "%APPDATA%\Composer" (
  mkdir "%APPDATA%\Composer"
)

IF NOT EXIST "%LOCALAPPDATA%\Composer" (
  mkdir "%LOCALAPPDATA%\Composer"
)

php -r "readfile('https://getcomposer.org/installer');" | php
