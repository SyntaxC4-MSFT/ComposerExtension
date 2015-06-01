# Install Composer

cd Commands

IF EXIST composer.phar (
  rm -f composer.phar
)

php -r "readfile('https://getcomposer.org/installer');" | php
