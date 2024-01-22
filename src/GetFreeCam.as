// c 2024-01-22
// m 2024-01-22

// everything here courtesy of "FreeCam: Show CP" plugin - https://github.com/XertroV/tm-freecam-show-cp

// pre 2023-11-21: 0x68
// 2023-11-21: 0x80
const uint ActiveCamControlOffset = 0x80;

uint16 GetMemberOffset(const string &in className, const string &in memberName) {
    // throw exception when something goes wrong.
    auto type = Reflection::GetType(className);
    auto member = type.GetMember(memberName);
    return member.Offset;
}

CGameControlCameraFree@ GetFreeCamControls(CGameCtnApp@ App) {
    if (App is null || App.GameScene is null || App.CurrentPlayground is null)
        return null;

    // get the game camera struct
    // orig 0x2b8; GameScene at 0x2a8
    auto gameCamCtrl = Dev::GetOffsetNod(App, GetMemberOffset("CGameManiaPlanet", "GameScene") + 0x10);
    if (gameCamCtrl is null)
        return null;

    if (Dev::GetOffsetUint64(gameCamCtrl, ActiveCamControlOffset) & 0xF != 0)
        return null;

    return cast<CGameControlCameraFree@>(Dev::GetOffsetNod(gameCamCtrl, ActiveCamControlOffset));
}