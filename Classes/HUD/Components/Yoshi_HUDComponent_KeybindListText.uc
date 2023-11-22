class Yoshi_HUDComponent_KeybindListText extends Yoshi_HUDComponent_KeybindList
    dependsOn(Yoshi_UkuleleInstrument_GameMod);

var string Text;
var float TextMargin;
var float TextSpace;

var Yoshi_HUDComponent_Text TextComponent;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    TextComponent.Text = Text;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function Render(HUD H) {
    local float PosX, PosY, SpaceX, SpaceY;

    Super(Yoshi_HUDComponent_Parent).Render(H);

    PosX = (CurTopLeftX + ((TextSpace + TextMargin) * CurScaleX)) * H.Canvas.ClipX;
    PosY = CurTopLeftY * H.Canvas.ClipY;
    SpaceX = (CurScaleX - ((TextSpace + TextMargin) * CurScaleX)) * H.Canvas.ClipX;
    SpaceY = CurScaleY * H.Canvas.ClipY;

    RenderKeys(H, PosX, PosY, SpaceX, SpaceY);
}

defaultproperties
{
    Begin Object Class=Yoshi_HUDComponent_Text Name=TextComp
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.6
        ScaleY=1.0
        BaseTextSize=0.8f
    End Object
    TextComponent=TextComp
    Components.Add(TextComp)

    TextSpace=0.6
    TextMargin=0.03
}