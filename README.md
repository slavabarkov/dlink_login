### D-Link DIR-615/DIR-655 login shell script  
A simple shell script that can be used to login to the D-Link DIR-615/DIR-655 router or any other router that uses a similar web interface. Made by reverse-engineering the web login JavaScript code, not guaranteed to work on every firmware version.  
### Usage  
Pass the router administrator password as the first script argument.  
After logging in, you can use curl to make further calls to the router, e.g. reboot the router with  
`curl 'http://192.168.0.1/reboot.cgi?reset=false'`
