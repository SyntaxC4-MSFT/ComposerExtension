# Install Composer

cd Composer

IF EXIST composer.phar (
  rm -f composer.phar
)

curl -sS https://getcomposer.org/installer | php