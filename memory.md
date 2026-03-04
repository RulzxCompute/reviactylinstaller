cd/var/www/pterodactyl
nano package.json

    "build": "cross-env NODE_OPTIONS=\"--max-old-space-size=6144\" NODE_ENV=development webpack --progress",
    "build:production": "yarn run clean && cross-env NODE_OPTIONS=\"--max-old-space-size=12288\" NODE_ENV=production webpack --mode production --progress"


yarn run build:production --progress
