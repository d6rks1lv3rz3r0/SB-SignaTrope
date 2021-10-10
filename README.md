# SB-SignaTrope
SignaTrope is a stand-alone navigation core that can be installed on any ship and will provide navigation related information for use in automation tasks. [Latest blueprint.](https://github.com/d6rks1lv3rz3r0/SB-SignaTrope/releases/download/v0.3.0/SignaTrope.v0.3.0.fbe).

![Front](/imagev03.png)

## Installation

0) Download the [latest release](https://github.com/d6rks1lv3rz3r0/SB-SignaTrope/releases/download/v0.3.0/SignaTrope.v0.3.0.fbe).
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
| Cord | Coordinate Stabilization Success  |
| Ori  | Orientation Stabilization Success |

## FAQ

### How Does Receiver Stabilization Work?

N/A

### Why 10 Receivers Instead of 4 or 12?

In an ideal environment where we are provided distances to a particular location (transmitters) in a cheat like manner such that there is no travel-time for the signal or doppler effects like in StarBase, you only need 3 points to uniquely determine the position of a ship with 1 caveat: it is not possible to determine which side of the origin circle (towards the planet or the belt) you are without having a 4th measurement. However, in practical cases it is only necessary to determine which side of the plane the ship resides once (and not individually for each set of receivers).

The system is designed to use the minimum number of receivers possible without changing signal target, grouped in the smallest packing possible so that it can fit almost any ship. For this you need exactly 10 receivers. 3 for Center Point 3 for Front 3 for Up 1 for Mirror Plane disambiguation

### Next
