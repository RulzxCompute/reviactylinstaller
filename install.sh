#!/bin/bash

echo "====================================="
echo "   Reviactyl installers Made By Rulzx"
echo "====================================="
echo ""
echo "Select option:"
echo "1. Install Reviactyl"
echo "2. Install Reviactyl Blueprint (Modded)"
echo ""
read -p "Enter option (1-2): " option

if [ "$option" == "1" ]; then
    echo "Installing Reviactyl..."
    cd /var/www/pterodactyl
    rm -rf *
    cd /var/www/pterodactyl
    curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache/
    COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
    php artisan migrate --seed --force
    chown -R www-data:www-data /var/www/pterodactyl/*
    sudo systemctl restart pteroq.service
    echo "Reviactyl installation complete!"

elif [ "$option" == "2" ]; then
    echo "Installing Reviactyl Blueprint (Modded)..."

    export PTERODACTYL_DIRECTORY=/var/www/pterodactyl

    sudo apt install -y curl wget unzip

    cd $PTERODACTYL_DIRECTORY

    wget "$(curl -s https://api.github.com/repos/reviactyl/blueprint/releases/latest | grep 'browser_download_url' | grep 'release.zip' | cut -d '"' -f 4)" -O "$PTERODACTYL_DIRECTORY/release.zip"
    unzip -o release.zip

    sudo apt install -y ca-certificates curl git gnupg unzip wget zip
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt update
    sudo apt install -y nodejs

    cd $PTERODACTYL_DIRECTORY
    npm i -g yarn
    yarn install

    touch $PTERODACTYL_DIRECTORY/.blueprintrc

    echo \
'WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";' > $PTERODACTYL_DIRECTORY/.blueprintrc

    chmod +x $PTERODACTYL_DIRECTORY/blueprint.sh
    bash $PTERODACTYL_DIRECTORY/blueprint.sh

    echo "Reviactyl Blueprint installation complete!"

else
    echo "Invalid option selected!"
    exit 1
fi
