class Yoshi_HUDComponent_ButtonText extends Yoshi_HUDComponent_Button;

var string Text;
var float BaseTextSize;

var Yoshi_HUDComponent_Text TextComponent;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    TextComponent.Text = Text;
    TextComponent.BaseTextSize = BaseTextSize;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

defaultproperties
{
    Begin Object Class=Yoshi_HUDComponent_Text Name=TextComp
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=1.0
        ScaleY=1.0
        BaseTextSize=0.8f
        TextAlignment=ElementAlign_Center
    End Object
    TextComponent=TextComp
    Components.Add(TextComp)

    MakeSquare=false
    Text="Button"
    BaseTextSize=0.8f
}