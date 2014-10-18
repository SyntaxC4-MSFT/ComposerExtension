# Install Composer

IF EXIST Composer (
  rd /S /q Composer
)

mkdir Composer
cd Composer
curl -sS https://getcomposer.org/installer | php

IF EXIST Composer.bat (
  rm -f Composer.bat
)

echo @php composer.phar %*>Composer.bat