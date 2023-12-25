namespace Logger
{
    string lines;

    void Add(const string &in line)
    {
        lines += line + "\n";
        trace(line);
    }

    void Clear()
    {
        lines = "";
    }

    void Render()
    {
        if (!Setting_ShowDebugLog)
            return;

        UI::Separator();
        if (UI::Button("Clear Log")) Clear();
        UI::PushStyleVar(UI::StyleVar::FrameBorderSize, 1.5f);
        UI::PushStyleColor(UI::Col::Border, vec4(UI::GetStyleColor(UI::Col::Button).xyz, 1.0f));
        lines = UI::InputTextMultiline("##logBuffer", lines, vec2(1000, 500));
        UI::PopStyleColor();
        UI::PopStyleVar();
    }

}

void Log(const string &in line)
{
    Logger::Add(line);  
}