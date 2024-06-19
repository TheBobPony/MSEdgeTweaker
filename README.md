# MSEdge Tweaker
Easily configure Microsoft Edge, the way you want it!
Please note, this project is still a work in progress! Please report any issues if you encounter any or open a discussion for any ideas to add/change for this project.

## How to use it?
### Method 1 (Recommended)
1. Press both Win and R keys together on the keyboard, a run dialog should appear.
2. Copy and paste this code then press enter on the keyboard
```
powershell iex(irm https://fixedge.today)
```
3. You will see the list of options. Follow the on-screen instructions.
### Method 2
1. Simply download the MSEdgeTweaker.cmd file from this repo
2. Run the downloaded script as Administrator then you will see the list of options. Follow the on-screen instructions.
3. Enjoy!

# Features
- Administrator Check: Ensures the script is run with administrator privileges.
- OS Version Check: Confirms the script is run on Windows 10 or newer.
- Domain Check: Determines if the device is joined to a domain and provides alternative options.
- Comprehensive Menu: Provides a variety of configuration options for Microsoft Edge.
- Logging: Implements logging with a timestamp, maintaining logs for up to 7 days.
- Apply All Option: Allows applying all configurations in one go, ensuring each option is executed only once per run.
- Undo Changes: Option to undo all changes made by the script.

# TO DO
- [-] Setup a dedicated domain for this project for use with PowerShell. (Done, see method 1)
- [-] Add checks to determine the device is domain joined or not. (Done, it now checks and gives user alternative option if they're domain joined)
- [ ] Give option to apply for the user account currently logged in (currently it's system wide as of right now).
- [ ] Sort options by most used by users that would typically disable in edge.
- [ ] Add more options that can be disabled and have the choice menu more organized as possible.
- [ ] Somehow get feature flags changed such as disabling rounded corners on webpages via script.
- [-] Option to undo changes made from this script. (Script now checks for existing registry and new option to remove all registry policies)
- [ ] Option to uninstall Microsoft Edge