//For "dangerous" buttons, makes you confirm with a second click
class Yoshi_HUDComponent_ButtonTextConfirm extends Yoshi_HUDComponent_ButtonText;

var string ConfirmText;
var float TimeToConfirm;

var float TimePassed;
var bool IsConfirming;

function Tick(HUD H, float delta) {
    if(IsConfirming) {
        TimePassed += delta;

        if(TimePassed >= TimeToConfirm) {
            IsConfirming = false;
        }
    }

	Super.Tick(H, delta);
}

function Render(HUD H) {
    TextComponent.Text = (IsConfirming) ? ConfirmText : Text;

    Super.Render(H);
}

function bool OnClick(EInputEvent EventType)
{
    if(Super(Yoshi_HUDComponent_Parent).OnClick(EventType)) return true;
    if(EventType != IE_Pressed) return false;

    if(IsConfirming) {
        //We have confirmed
        OnClickButton();
        IsConfirming = false;
        TimePassed = 0.0f;
    }
    else {
        //Confirm first before clicking
        IsConfirming = true;
        TimePassed = 0.0f;
    }

    return true;
}

defaultproperties
{
    ConfirmText="Confirm?"
    TimeToConfirm=2.0
}