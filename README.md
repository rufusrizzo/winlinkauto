# winlinkauto
Our Goal is to include config files and scripts to automate the sending/receiving of WinLink messages.  The thought is to install these on a Raspberry Pi to make things like Field Day easier.  Maybe one day a VM for everyday users to send WinLink messages more reliably.

The basics of these scripts are to get a list of RMS gateways and automatically connect to them.  My goals are to add tools to predict which gateways are able for you to connect to.  The other thought is to have the scripts find gateways you can reach at certain times of day.   





## Tasks
### Rollout for testing

- [X] Setup basic structure
- [X] Add good GW check
- [X] Set pass/fail based on outbox contents, "kind of" it won't attempt if the outbox is empty
- [X] Collect connection logs
- [ ] Initial setup configuration scripts
- [X] Build good GW list based on previous connections
- [X] Add option to skip Good GWs
- [ ] Installation setup scripts
- [ ] Check Radio settings, Mode, AGC, Power, Audio BW
- [ ] Directory to have radio setting files
- [x] Process Run mgmt scripts
- [x] Create a way to monitor and run everything
- [ ] Process Run mgmt config, ie change radios and update start scripts
- [ ] Create Pi Image
- [ ] Create Windows VM
- [ ] Automate/Test install scripts
- [ ] Add feature to restart apps if USB disconnect is detected
- [ ] Add Help/usage to all scripts

### Features

- [x] Add P2P scripts
- [ ] Add P2P scripts, none Winlink Wed
- [ ] Need to rank the Good GWs based on successful sends
- [ ] Need to rank the Good GWs based on successful send times and the current time
- [X] Generate GWs from good connections bearing
- [ ] Generate GWs from good connections distance
- [ ] Make decisions based on Solar Conditions
- [ ] Add script to ignore Good GWs to find good gws
- [ ] Get solar conditions every 3 hours
- [ ] Ask for antenna info, set GW bearing
- [ ] Web configuration tool
- [ ] Maybe setup Klish for the above scripts
- [ ] Radio detection when using two radios
- [X] Automate HF and VHF sending for Winlink Wednesday
- [ ] ICS-213 send scripts
- [ ] Add Weather based on gridsquare
- [ ] Add choice for multiple HF bands
- [ ] Add Tuning between bands
- [x] Add Tuning between bands, p2p
- [ ] Update GW list from HF
- [ ] Update GW list from VHF
- [ ] Setup APRS Digipeter/Igate in Standby mode
- [ ] Read Direwolf log for VHF to collect heard stations
- [ ] Decode heard traffic
- [ ] Setup basic GW connection test
- [ ] Add VARA and VARA FM
- [ ] Detect VARA or ARDOP heard traffic
- [ ] Get signal strength from the radio during connection

