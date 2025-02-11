
## Wordpress
* [install](https://runcloud.io/blog/install-wordpress-on-docker)
* ```docker-compose up -d``` at the ex directory
* ERR > check if docker desktop is running

## wiki
* [install](https://gerrit.wikimedia.org/g/mediawiki/core/+/HEAD/DEVELOPERS.md)
* ```docker compose up -d``` at the wiki directory

## nordvpn
* [login problem](https://askubuntu.com/questions/1384955/cannot-log-into-nord-vpn)


> nordvpn help login will give you hints. The default browser based login worked for me, but instead of opening the link at the success page, I copied the nordvpn://... url (or replaced https:// with nordvpn:// to build the URL), and finished logging in in the console by using nordvpn login --callback "nordvpn://success-uri-I-copied-from-browser". After this, login was successful.
> Actually, just Copy link from the button and use ```nordvpn login --callback "url..."```
