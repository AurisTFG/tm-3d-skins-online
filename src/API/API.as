namespace API
{
    Json::Value@ CoreRequest(const string &in route)
    {
        string url = NadeoServices::BaseURLCore() + route;

        NadeoServices::AddAudience("NadeoServices");
        if (!NadeoServices::IsAuthenticated("NadeoServices")) 
            yield();

        auto req = NadeoServices::Get("NadeoServices", url);
        req.Start();
        trace("Requesting: " + url);
        while (!req.Finished()) 
            yield();

        string response = req.String();
        trace("API response: " + response);

        auto json = Json::Parse(response);
        return json;
    }

    string GetSkinId(const string &in skinType = "Models/CarSport") // gets currently equipped skin id
    {
        string route = "/accounts/" + NadeoServices::GetAccountID() + "/skins/" + skinType;

        auto json = CoreRequest(route);
        if (!json.HasKey("skinId"))
            return "";

        string skinId = json["skinId"];
        return skinId;
    }

    string GetSkinUrl(const string &in skinId) // gets the correct url for the skin
    {
        string route = "/skins/" + skinId;

        auto json = CoreRequest(route);
        if (!json.HasKey("fileUrl"))
            return "";

        string fileUrl = json["fileUrl"];
        return fileUrl;
    }

    string GetSkinUrl() // gets the correct url for the skin
    {
        string skinId = GetSkinId();
        if (skinId == "")
            return "";
        
        string fileUrl = GetSkinUrl(skinId);
        return fileUrl;
    }
}