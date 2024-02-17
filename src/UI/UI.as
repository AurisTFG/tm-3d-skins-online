const vec4 customBorderColor = vec4(UI::GetStyleColor(UI::Col::Button).xyz, 1.0f);

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

    void PushBorder(float size = 1.0f, vec4 color = customBorderColor)
    {
        UI::PushStyleVar(UI::StyleVar::FrameBorderSize, size);
        UI::PushStyleColor(UI::Col::Border, color);
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

    void TableHeader(const int &in column, const string &in text)
    {
        UI::TableSetColumnIndex(column); 
        UI::TableHeader(text); 
        UI::Separator();
    }
}