_timer = 9999999;
clicked = false;
params ["_target", "_caller", "_actionId", "_arguments"];
private _helo = _target;
   /*
// IF NOT ENOUGH PTS
if (commandpointsblu1<3) exitWith {
  ["info",["Not enough command points","Not enough Command Points (3CP required)"]] call bis_fnc_showNotification;
  sleep 30;
_art = [player,"uav_recon"] call BIS_fnc_addCommMenuItem;
};
  */
/*  
_invalidPos = [[0,0,0], 0,9999999999999,7,0,0.2,0] call BIS_fnc_findSafePos; // invalid pos reference
_foundPickupPos = [_pos, 0,50,7,0,0.2,0] call BIS_fnc_findSafePos; // find a valid pos

if (_invalidPos select 0 == _foundPickupPos select 0 && _invalidPos select 1 == _foundPickupPos select 1) exitWith {player sidechat "There is no clear LZ near that location"};  
*/
  
titleText ["Pilot: Click somewhere on your map to give me a LZ, I'll see what i can do", "PLAIN DOWN"];
OnMapSingleClick "ClickedTaxiPos = _pos; clicked = true;";
_helo removeAction _actionID;



// TIMER & MAPCLICK
while {_timer>0} do {
    if (clicked) then { // player has clicked the map
    _foundPickupPos = [ClickedTaxiPos, 0,50,10,0,0.2,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos; // find a valid pos

    if (0 == _foundPickupPos select 0 && 0 == _foundPickupPos select 1) then {
        if (ClickedTaxiPos distance player < 1000) exitWith {
        clicked = false;
        titleText ["Pilot: This LZ is too close from our position", "PLAIN DOWN"];
        };
    clicked = false;
    titleText ["Pilot: No clear LZ around here, give me another location", "PLAIN DOWN"];
    }
    else
    {onMapSingleClick "";_timer = 0;taxiCanTakeOff = true;}  
    
    };
  _timer = _timer-1; // remove 1 to timer
  sleep 0.5;
};
