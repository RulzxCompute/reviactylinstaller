```
cd/var/www/pterodactyl
```
```
nano package.json
```

    "build:production": "yarn run clean && cross-env NODE_ENV=production NODE_OPTIONS=\"--max-old-space-size=4096 --openssl-legacy-provider\" ./node_modules/.bin/webpack --mode production",

```
yarn run build:production --progress
```
