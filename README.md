# winlinkauto
Our Goal is to include config files and scripts to automate the sending/receiving of WinLink messages.  The thought is to install these on a Raspberry Pi to make things like Field Day easier.  Maybe one day a VM for everyday users to send WinLink messages more reliably.

The basics of these scripts are to get a list of RMS gateways and automatically connect to them.  My goals are to add tools to predict which gateways are able for you to connect to.  The other thought is to have the scripts find gateways you can reach at certain times of day.   





## Tasks

- [X] Setup basic structure
- [X] Add good GW check
- [ ] Collect connection logs
- [X] Set pass/fail based on outbox contents, "kind of" it won't attempt if the outbox is empty
- [ ] Automate HF and VHF sending for Winlink Wednesday
- [ ] Add Weather based on gridsquare
- [ ] Add choice for multiple HF bands
- [ ] Add Tuning between bands
- [ ] Update GW list from HF
- [ ] Update GW list from VHF
- [ ] Configuration setup scripts
- [ ] Ask for antenna info, set GW bearing
- [ ] Maybe setup Klish for the above scripts
- [ ] Automate/Test install scripts
- [ ] Create Pi Image
- [ ] Create Windows VM
- [ ] Setup APRS Digipeter/Igate in Standby mode
- [ ] Decode heard traffic
- [ ] Setup basic GW connection test
- [ ] Add VARA and VARA FM
- [ ] Detect VARA or ARDOP heard traffic

