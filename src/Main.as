// c 2024-01-22
// m 2024-02-25

bool         overrideKey = false;
const string title       = "\\$FA0" + Icons::Kenney::Forward + "\\$G FreeCam Speed Limiter";

void Main() {
    versionSafe = GameVersionSafe();
    S_OverrideCheck = false;

    while (true) {
        yield();

        if (S_Enabled && versionSafe) {
            CGameControlCameraFree@ Cam = GetFreeCamControls();

            if (overrideKey || Cam is null)
                continue;

            if (Cam.m_MoveSpeed < S_MinLimit)
                Cam.m_MoveSpeed = S_MinLimit;

            if (Cam.m_MoveSpeed > S_MaxLimit)
                Cam.m_MoveSpeed = S_MaxLimit;
        }
    }
}

void RenderMenu() {
    if (UI::MenuItem(title + (versionSafe ? "" : "\\$AAA (disabled" + (checkingApi ? ", checking..." : "") + ")"), "", S_Enabled, versionSafe))
        S_Enabled = !S_Enabled;
}

void OnKeyPress(bool down, VirtualKey key) {
    overrideKey = down && key == S_Key;
}

void OnSettingsChanged() {
    if (S_MinLimit < 0.0f)
        S_MinLimit = 0.0f;

    if (S_MaxLimit < 0.0f)
        S_MaxLimit = 0.0f;

    if (S_MinLimit > S_MaxLimit) {
        float min = S_MinLimit;
        S_MinLimit = S_MaxLimit;
        S_MaxLimit = min;
    }

    if (S_OverrideCheck)
        versionSafe = true;
}