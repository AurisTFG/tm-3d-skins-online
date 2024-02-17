const string pluginName = Meta::ExecutingPlugin().Name;
const bool isDev = pluginName.ToLower().EndsWith("(dev)");
const bool isClubAccess = OpenplanetHasFullPermissions();

string windowLabel = "\\$ff0" + Icons::Exchange + (isDev ? "\\$d00 " : "\\$z ") + pluginName;
bool isWindowOpen = (isDev ? true : false);

string g_SkinUrlInput = "";
bool g_AutoUpdateSkinUrl = true;

void Main() 
{
   if (!isClubAccess)
   {
      UI::ErrorNotificaiton("Club access is required to use this plugin.");
      return;
   }

   auto player = GetApp().LocalPlayerInfo;
   string previousSkinName = "";

   while (true)
   {
      if (g_AutoUpdateSkinUrl)
      {
         if (player.Model_CarSport_SkinName != previousSkinName)
         {
            previousSkinName = player.Model_CarSport_SkinName;
            startnew(ChangeSkinUrlCoro);
         }
      }

      sleep(1000);
   }
}

void Update(float dt)
{
	TextFade::Update(dt);
}

void RenderMenu()
{
   if (UI::MenuItem(windowLabel, "", isWindowOpen)) 
      isWindowOpen = !isWindowOpen;
}

void RenderInterface()
{
   if (isWindowOpen && isClubAccess) 
      RenderWindow();
}

void RenderWindow()
{
   if (UI::Begin(windowLabel, isWindowOpen, UI::WindowFlags::NoCollapse | UI::WindowFlags::NoResize | UI::WindowFlags::AlwaysAutoResize))
   {
      UI::PushBorder();
      g_AutoUpdateSkinUrl = UI::Checkbox("Automatically Fix Skin URL", g_AutoUpdateSkinUrl);
      UI::PopBorder();
      UI::AddTooltipOfWidth("Automatically detects when a different skin is being equipped and immediately updates the download URL of the skin to the correct (unoptimized) one from API.", 400);

      if (UI::Button("Fix Skin URL"))
      {
         startnew(ChangeSkinUrlCoro);
      }
      UI::AddTooltipOfWidth("Changes the download URL of the currently equipped skin to the correct one by getting the unoptimized file url from API.", 400);

      UI::Separator();

      UI::Text("Skin Download URL:");
      UI::SameLine();

      UI::SetNextItemWidth(600);
      UI::PushBorder();
      g_SkinUrlInput = UI::InputText("##URL", g_SkinUrlInput);
      UI::PopBorder();

      if (UI::Button("Change Skin URL"))
      {
         ChangeSkinUrl(g_SkinUrlInput);
      }
      UI::AddTooltipOfWidth("Changes the skin download URL to the given URL above.", 300);

      TextFade::Render();

      Logger::Render();
   }

   UI::End();
}

void ChangeSkinUrlCoro()
{
   string skinUrl = API::GetSkinUrl();
   if (skinUrl == "")
   {
      TextFade::Start("No skin is selected. Please equip a skin in the game or manually enter the download url.", LogLevel::Error);
      return;
   }

   ChangeSkinUrl(skinUrl);
}

void ChangeSkinUrl(const string &in skinUrl)
{
   if (skinUrl == "")
   {
      TextFade::Start("Given skinUrl is empty", LogLevel::Error);
      return;
   }

   uint64 skinUrlPtr = Dev::GetSkinUrlPtr();
   Log("SkinUrlPtr: " + Text::FormatPointer(skinUrlPtr));
   if (!Dev::IsPtrValid(skinUrlPtr, true))
   {
      TextFade::Start("No valid pointer was found. PLEASE REPORT THIS @auristfg", LogLevel::Error);
      return;
   }

   string oldSkinUrl = Dev::ReadCString(skinUrlPtr);
   Log("SkinUrl before: " + oldSkinUrl + " (" + oldSkinUrl.Length + ")");

   Dev::WriteCStringWith00(skinUrlPtr, skinUrl);

   string newSkinUrl = Dev::ReadCString(skinUrlPtr);
   Log("SkinUrl after: " + newSkinUrl + " (" + newSkinUrl.Length + ")\n");

   TextFade::Start("The skin url has been successfully changed!", LogLevel::Success);
}