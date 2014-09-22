disableSerialization;
/**DoorManagement Config**/
DoorAdminList = ["-2","-3"]; // List of Player Id's of admins that can manage all doors
AllowManualCode = true;// 2 reason| 1: Allows breaking codes (if 2nd config = false and code = 3 digits) | 2: Friends can access access not owned doors until owner gets on.
HarderPenalty = true;// Cen's Penalty: Flashes screen white. And kicks player to lobby if failed more then (random number between 4 and 14) times.
// AllowUncrackableCode = false; // in next release: if set to true, player can change code to more then 4 digits, The manualCode will always fail when he does. THIS is for AntiCodeCrack servers that allow Manual Code for people that like that system.
// in next release. AllowManualCode will allow players to change the code in the DoorManagement Menu.
/**DoorManagement Config END**/

if(count(_this) > 0)then{
TheDoor = _this select 3;
}else{
TheDoor = dayz_selectedDoor;
};
_display = findDisplay 41144;
_display closeDisplay 3000;
_canOpen = false;
_friends = TheDoor getVariable ["doorfriends",[]];
{
if ((_x  select 0) == (getPlayerUID player)) then{ _canOpen = true; }; 
} forEach _friends;

if ((TheDoor getVariable ["ownerPUID","-2"]) == (getPlayerUID player)) then{ _canOpen = true; }; 

if(isNil "DoorAdminList")then{DoorAdminList = ["-2"];};
if ((getPlayerUID player) in DoorAdminList) then{ _canOpen = true; }; 

if(_canOpen)then{
createDialog "DoorManagement";
call DoorNearbyHumans;
call DoorGetFriends;
}else{
cutText ["You do not have the rights to manage.","PLAIN DOWN"];
};