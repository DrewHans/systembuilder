# openwrt

After flashing OpenWrt to the router, verify that you can connect to router and then to the internet.

Next run computer.sh on your computer and then verify you can ssh into the router without a password before continuing.

Then, ssh into the router and run router.sh.
Warning: this will lockdown the router and prevent ssh password authentication.
Verify you can ssh in using only your ssh key!

Lastly, go to https://192.168.1.1/cgi-bin/luci/ and login.
Change the password and store the new one somewhere secure.
Make it something long (128+ characters) and random (no dictionary words).

Once all of the above has been completed, the router is setup and ready to go.
Be sure to setup the network interfaces for wifi if they are not working.
