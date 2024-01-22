// c 2024-01-22
// m 2024-01-22

[Setting category="General" name="Enabled"]
bool S_Enabled = false;

[Setting category="General" name="Speed limit" min=0.0f max=1000.0f description="0 would normally mean stopped, but because of how the speed limit works, it just means very slow"]
float S_Limit = 100.0f;

[Setting category="General" name="Override game version check (unsafe)" description="If you don't want to wait for the plugin author to test the current game version, try this setting. \\$FA0It may crash your game."]
bool S_OverrideCheck = false;