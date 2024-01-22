// c 2024-01-22
// m 2024-01-22

const string title = "\\$FA0" + Icons::Kenney::Forward + "\\$G FreeCam Speed Limiter";

void RenderMenu() {
    if (UI::MenuItem(title + (versionSafe ? "" : "\\$AAA (disabled" + (checkingApi ? ", checking..." : "") + ")"), "", S_Enabled, versionSafe))
        S_Enabled = !S_Enabled;
}

void Main() {
    versionSafe = GameVersionSafe();
    S_OverrideCheck = false;

    while (true) {
        if (S_Enabled && versionSafe) {
            CGameControlCameraFree@ Cam = GetFreeCamControls(GetApp());
            if (Cam !is null && Cam.m_MoveSpeed > S_Limit)
                Cam.m_MoveSpeed = S_Limit;
        }

        yield();
    }
}

void OnSettingsChanged() {
    if (S_Limit < 0.0f)
        S_Limit = 0.0f;

    if (S_OverrideCheck)
        versionSafe = true;
}