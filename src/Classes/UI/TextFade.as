const vec4 WhiteColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
const vec4 GreenColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
const vec4 YellowColor = vec4(1.0f, 1.0f, 0.0f, 1.0f);
const vec4 RedColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
const array<vec4> Colors = { WhiteColor, GreenColor, YellowColor, RedColor };

enum LogLevel 
{
    Info = 0, 
    Success = 1, 
    Warning = 2, 
    Error = 3
}

namespace TextFade
{ 
    const float durationMs = 3000.0f;
    vec4 currentColor = -1.0f;
    string currentText = "";

    void Start(const string &in text, LogLevel level = LogLevel::Info, bool printToLog = true)
    {
        currentText = text;
        currentColor = Colors[level];

        if (printToLog)
        {
            switch (level)
            {
                case LogLevel::Info:
                    trace(text);
                    break;
                case LogLevel::Success:
                    print(text);
                    break;
                case LogLevel::Warning:
                    warn(text);
                    break;
                case LogLevel::Error:
                    error(text);
                    break;
            }
        }
    }
    
    void Stop()
    {
        currentText = "";
        currentColor.w = 0.0f;
    }

    void Render()
    {
        if (currentText == "")
            return;

        if (currentColor.w <= 0.0f)
        {
            return;
        }
            
        UI::PushStyleColor(UI::Col::Text, currentColor);
        UI::Text(currentText);
        UI::PopStyleColor();
    }

    void Update(float dt)
    {
        if (currentText == "" || currentColor.w <= 0.0f)
            return;
        
        currentColor.w -= dt / durationMs;
    }
}