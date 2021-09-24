# SB-SignaTrope
![Front](/image.png)
SignaTrope is a stand-alone navigation core that can be installed on any ship and will provide navigation related information for use in automation tasks.

## Installation

0) Download the [latest release](https://github.com/d6rks1lv3rz3r0/SB-SignaTrope/releases/download/v.0.1.2/SignaTrope.v0.1.2.fbe).
1) Load the blueprint file and turn it into a module.
2) Add the module to anywhere you like on yourship.
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

