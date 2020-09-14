class ZMHudWidgetHints extends ROHudWidgetHints
    Config(Mutator_ZM_Client);


enum EZMTrigHints
{
    ZMHTrig_Dummy0,
    ZMHTrig_Dummy1,
    ZMHTrig_Dummy2,
    ZMHTrig_Dummy3,
    ZMHTrig_Dummy4,
    ZMHTrig_Dummy5,
    ZMHTrig_Dummy6,
    ZMHTrig_Dummy7,
    ZMHTrig_Dummy8,
    ZMHTrig_Dummy9,
    ZMHTrig_Dummy10,
    ZMHTrig_Dummy11,
    ZMHTrig_Dummy12,
    ZMHTrig_Dummy13,
    ZMHTrig_Dummy14,
    ZMHTrig_Dummy15,
    ZMHTrig_Dummy16,
    ZMHTrig_Dummy17,
    ZMHTrig_Dummy18,
    ZMHTrig_Dummy19,
    ZMHTrig_Dummy21,
    ZMHTrig_Dummy22,
    ZMHTrig_Dummy23,
    ZMHTrig_Dummy24,
    ZMHTrig_Dummy25,
    ZMHTrig_Dummy26,
    ZMHTrig_Dummy27,
    ZMHTrig_Dummy28,
    ZMHTrig_Dummy29,
    ZMHTrig_Dummy30,
    ZMHTrig_Dummy31,
    ZMHTrig_Dummy32,
    ZMHTrig_Dummy33,
    ZMHTrig_Dummy34,
    ZMHTrig_Dummy35,
    ZMHTrig_Dummy36,
    ZMHTrig_Dummy37,
    ZMHTrig_Dummy38,
    ZMHTrig_Dummy39,
    ZMHTrig_Dummy40,
    ZMHTrig_Dummy41,
    ZMHTrig_Dummy42,
    ZMHTrig_Dummy43,
    ZMHTrig_Dummy44,
    ZMHTrig_DummyMax, // ROHTrig_Max
    ZMHTrig_Katana,
    ZMHTrig_Max
};

var config array<Hint> ZMTriggeredHints;


simulated event PostBeginPlay()
{
    super.PostBeginPlay();

    /* TODO: doesn't work.
    if (int(ZMHTrig_DummyMax) != int(ROHTrig_Max))
    {
        `zmlog("ERROR: Enum alignment mismatch (ZMHTrig_DummyMax != ROHTrig_Max)", 'Error');
    }
    */
}

function AddHintStrings(int HintID, out string TitleString, out string BodyString,
    bool bTriggeredHint, bool bIsRandomHint)
{
    if (HintID > ROHTrig_Max)
    {
        if (bTriggeredHint)
        {
            TitleString = Localize(default.ZMTriggeredHints[HintID].LocalizedSectionString, "TitleString", "ROGame");
            BodyString = Localize(default.ZMTriggeredHints[HintID].LocalizedSectionString, "BodyString", "ROGame");

            switch (HintID)
            {
                case ZMHTrig_Katana:
                    AddLocalizedKey(BodyString, "%SPRINT%", "Sprint");
                    AddLocalizedKey(BodyString, "%MELEE%", "AltFire");
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        super.AddHintStrings(HintID, TitleString, BodyString, bTriggeredHint, bIsRandomHint);
    }
}

function DisableHint(int HintID, bool bHintTriggered)
{
    if (HintID > ROHTrig_Max)
    {
        /*
        if (bHintsInitialized && default.bShowHints)
        {
            if (bHintTriggered)
            {
                if(default.ZMTriggeredHints[HintID].HintsLeft != 0
                    && default.ZMTriggeredHints[HintID].HintsShown > 0)
                {
                    default.ZMTriggeredHints[HintID].HintsLeft = 0;
                    StaticSaveConfig();
                }
            }
        }
        else
        {
            if (default.ZMTriggeredHints[HintID].HintsLeft != 0)
            {
                // Only disable the hint if it's been shown at least once
                if(default.ZMTriggeredHints[HintID].HintsShown > 0)
                {
                    default.ZMTriggeredHints[HintID].HintsLeft = 0;
                    StaticSaveConfig();
                }
                else
                {
                    // If we have never seen the hint, give it another chance to appear rather than disabling it.
                    HintsDisplayTime[HintID] = WorldInfo.GRI.RemainingTime - default.ZMTriggeredHints[HintID].Frequency;
                }

                if (PriorityHintID == HintId)
                {
                    ZMPossibleTimedHintIDs.Remove(0, ZMPossibleTimedHintIDs.Length);
                    GetNextTimedHint();
                }
            }
        }
        */
    }
    else
    {
        super.DisableHint(HintID, bHintTriggered);
    }
}
