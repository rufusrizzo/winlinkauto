# winlinkauto
Our Goal is to include config files and scripts to automate the sending/receiving of WinLink messages.  The thought is to install these on a Raspberry Pi to make things like Field Day easier.  Maybe one day a VM for everyday users to send WinLink messages more reliably.

The basics of these scripts are to get a list of RMS gateways and automatically connect to them.  My goals are to add tools to predict which gateways are able for you to connect to.  The other thought is to have the scripts find gateways you can reach at certain times of day.   





## Tasks
### Rollout for testing

- [X] Setup basic structure
- [X] Add good GW check
- [X] Set pass/fail based on outbox contents, "kind of" it won't attempt if the outbox is empty
- [X] Collect connection logs
- [ ] Generate Good GWs, remove dupe callsigns, add band it was good on
- [ ] Build good GW list based on previous connections, add option to skip Good GWs
- [ ] Configuration setup scripts
- [ ] Create Pi Image
- [ ] Create Windows VM
- [ ] Automate/Test install scripts
- [ ] Add feature to restart apps if USB disconnect is detected

### Features

- [ ] Add P2P scripts
- [ ] Need to rank the Good GWs based on successful sends
- [ ] Need to rank the Good GWs based on successful send times and the current time
- [ ] Look at good connections, gather bearing and distance
- [ ] Ask for antenna info, set GW bearing
- [ ] Web configuration tool
- [ ] Maybe setup Klish for the above scripts
- [ ] Radio detection when using two radios
- [ ] Automate HF and VHF sending for Winlink Wednesday
- [ ] Add Weather based on gridsquare
- [ ] Add choice for multiple HF bands
- [ ] Add Tuning between bands
- [ ] Update GW list from HF
- [ ] Update GW list from VHF
- [ ] Setup APRS Digipeter/Igate in Standby mode
- [ ] Read Direwolf log for VHF to collect heard stations
- [ ] Decode heard traffic
- [ ] Setup basic GW connection test
- [ ] Add VARA and VARA FM
- [ ] Detect VARA or ARDOP heard traffic

