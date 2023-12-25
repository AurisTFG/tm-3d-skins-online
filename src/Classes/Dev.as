namespace Dev
{
    bool IsPtrValid(uint64 ptr)
    {
        return 
            ptr > 0x100000 && 
            ptr < Dev::BaseAddressEnd();
            // ptr % 8 == 0;
    }
    
    uint64 GetSkinUrlPtr(const string &in _skinType = "Models/CarSport") // gets pointer to skin download url
    {
        auto profile = GetApp().CurrentProfile.ProfileNew;

        uint64 ptr = Dev::GetOffsetUint64(profile, 0x300);
        if (!IsPtrValid(ptr)) return 0;

        ptr = Dev::ReadUInt64(ptr + 0x30);
        if (!IsPtrValid(ptr)) return 0;

        int arraySize = 2;
        uint64 structSize = 0x90;
        for (int i = 0; i < arraySize; i++) // always gotta do this bcuz carsport and characterpilot like to switch places
        {
            string skinType  = Dev::ReadCString(Dev::ReadUInt64(ptr + i * structSize + 0x58));
            if (skinType == _skinType)
            {
                uint64 skinUrlPtr = Dev::ReadUInt64(ptr + i * structSize + 0x78);
                if (!IsPtrValid(skinUrlPtr)) return 0;

                return skinUrlPtr;
            }
        }   

        return 0;
    }

    void WriteCStringWith00(uint64 ptr, const string &in str)
    {
        Dev::WriteCString(ptr, str);
        Dev::Write(ptr + str.Length, uint8(0));
    }
}

// GetApp().CurrentProfile.ProfileNew;
// + 0x300 ptr to something
// + 0x30 ptr to array of structs (array size: 2)

// the struct: (size: 0x90)
// + 0x0 skin checksum 0x20 bytes

// + 0x20 ptr to skinID string (0440ab36-dbdb-4445-9477-48eca84537a2)
// + 0x2C uint32 string length

// + 0x30 ptr to skiDisplayName string, string itself, if it fits (HNYZiren_W_by_SMS)
// + 0x3C uint32 string length

// + 0x40 ptr to thumbnail url string
// + 0x3C uint32 string length

// + 0x50 epoch timestamp of when skin was uploaded

// + 0x58 ptr to skin type string (Models/CarSport or Models/CharacterPilot)
// + 0x64 uint32 string length

// + 0x68 ptr to skinName string (Skins\Models\CarSport\HNYZiren_W_by_SMS.zip)
// + 0x74 uint32 string length

// + 0x78 ptr to skin download url string
// + 0x84 uint32 string length
