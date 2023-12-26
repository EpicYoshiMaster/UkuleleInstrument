//Class to fix shared coop menu HUDs
class Yoshi_HUDMenu_SharedCoop extends Hat_HUDMenu;

function OnOpenHUD(HUD H, optional String command)
{
    local Hat_HUD MouseHUD;

	Super(Hat_HUDElement).OnOpenHUD(H, command);

    Open = true;

	if (RequiresMouse)
	{
        MouseHUD = GetKeyboardHUD(H);

        if(MouseHUD != None) {
            SetMouseHidden(MouseHUD, false);
        }
	}
}

function Hat_HUD GetKeyboardHUD(HUD H) {
    if(!IsGamepad(H)) return Hat_HUD(H);

    H = Hat_HUD(H).GetOtherPlayerHUD();

    if(SharedInCoop && !IsGamepad(H)) return Hat_HUD(H);

    return None;
}

function ReactivateMouseCheck(HUD H)
{
	local Vector2D MousePos;
    local Hat_HUD MouseHUD;

	if (RequiresMouse && !MouseActivated)
	{
        MouseHUD = GetKeyboardHUD(H);

        if(MouseHUD != None) {
            MousePos = LocalPlayer(MouseHUD.PlayerOwner.Player).ViewportClient.GetMousePosition();
		    if (Abs(MousePos.X - MouseIdleLocation.X) + Abs(MousePos.Y - MouseIdleLocation.Y) > 5)
		    {
			    SetMouseHidden(MouseHUD, false);
		    }
        }
	}
}

defaultproperties
{
    SharedInCoop=true
}