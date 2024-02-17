namespace UI
{
    void AddTooltipOfWidth(const string &in msg, int width = 400) 
    {
        UI::SameLine();
		UI::TextDisabled("(?)");
        if (UI::IsItemHovered()) {
            UI::SetNextWindowSize(width, -1, UI::Cond::Always);
            UI::BeginTooltip();
            UI::TextWrapped(msg);
            UI::EndTooltip();
        }
    }

    void PushBorder()
    {
        UI::PushStyleVar(UI::StyleVar::FrameBorderSize, 1.0f);
        UI::PushStyleColor(UI::Col::Border, vec4(UI::GetStyleColor(UI::Col::Button).xyz, 1.0f));
    }

    void PopBorder()
    {
        UI::PopStyleColor();
        UI::PopStyleVar();
    }

    void ErrorNotificaiton(const string &in message)
    {
        UI::ShowNotification(pluginName + ": Error", message, vec4(1.0f, 0.0f, 0.0f, 0.0f));
    }
}