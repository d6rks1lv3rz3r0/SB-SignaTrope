# SB-SignaTrope
![Front](/image.png)
SignaTrope is a stand-alone navigation core that can be installed on any ship and will provide navigation related information for use in automation tasks.

## Installation

0) Download the [latest release](https://github.com/d6rks1lv3rz3r0/SB-SignaTrope/releases/download/v.0.1.2/SignaTrope.v0.1.2.fbe).
1) Load the blueprint file and turn it into a module.
2) Add the module to anywhere you like on your ship.
3) Weld the beams to your frame, connect the power cable from the front.
4) Take the control/dash elements on the core and place them on your control board.

## Pin-Out
| Variable  | Description |
|------|-----------------------------------|
| 0    | CrossHair Screen                  |
| 1    | Coordinates Screen                |
| 2    | Delta Screen                      |
| 3    | Speed Screen                      |
| 4    | WayPoint Screen                   |
|      |                                   |
| X    | Stabilized X Coordinate           |
| Y    | Stabilized Y Coordinate           |
| Z    | Stabilized Z Coordinate           |
| vF   | Stabilized Forward Speed          |
| vU   | Stabilized Upward Speed           |
| vR   | Stabilized Rightward Speed        |
| DX   | Delta X Since Last Update         |
| DY   | Delta Y Since Last Update         |
| DZ   | Delta Z Since Last Update         |
| DWPx | Delta X to WayPoint               |
| DWPy | Delta Y to WayPoint               |
| DWPz | Delta Z to WayPoint               |
| DWPD | Distance to WayPoint              |
| WPCx | Current WayPoint X                |
| WPCy | Current WayPoint Y                |
| WPCz | Current WayPoint Z                |
| Pit  | Pitch Angle to WayPoint           |
| Yaw  | Yaw Angle to WayPoint             |
| Nav  | Receiver Stabilization Success    |
| Nav2 | Coordinate Stabilization Success  |
| Ori  | Orientation Stabilization Success |

## FAQ

### How Does Receiver Stabilization Work?
Receivers and the YOLOL code that will use their value get executed in a random order within a single YOLOL tic, meaning sometimes YOLOL may compute before receiver updates or it after it updates twice depending on how they happened to be ordered. To accomodate this in a brute-force way, the system enforces that readings from all 9 receivers agree with each other whether they are all delayed, or over ticced or all proper.

The following line checks whether all receivers pointing to a particular Origin Transmitter (like East) show values within a particular tolerance based on their seperation inside the core. If they do, a flag is set to `1`. This is repeated times for each set of 3 transmitters pointing to the same transmitter (Front, Center and Up Points)

```pony
fd=abs(:F1S-:O1S) ud=abs(:U1S-:O1S) i=(fd<2.5)*(ud<2.5) :Chk1=i
```
The values from the receivers are allowed to pass for further processing only if all checks on all 9 transmitters report a GO.

```pony
if :Chk1*:Chk2*:Chk3 then :O1=:O1S :F1=:F1S :U1=:U1S end goto1
```
Whether this has happened successfully is reported on the status light `:Nav`.
```pony
:Nav=:Chk1*:Chk2*:Chk3 goto1
```

### Next Question
