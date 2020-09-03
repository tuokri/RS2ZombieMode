class PAPLogger extends Object
    config(Mutator_PicksAndPistols);

struct LogStruct
{
    var string Tag;
    var bool Enabled;
};

var config array<LogStruct> LogOptions;


static function PAPLog(string Message, optional name Tag)
{
    local int i;
    local int j;
    local bool LogExists;
    local LogStruct InData;

    Tag = (Tag == 'None') ? 'PAP' : name('PAP-' $ Tag);
    LogExists = False;
    j = 0;

    for (i = 0; i < default.LogOptions.length; i++)
    {
        if (string(Tag) ~= default.LogOptions[i].Tag)
        {
            LogExists = True;
            j = i;
            break;
        }
    }

    if (LogExists && default.LogOptions[j].Enabled)
    {
        `log(Message, , Tag);
    }
    else if (!LogExists)
    {
        InData.Tag = string(Tag);
        InData.Enabled = True;

        default.LogOptions[default.LogOptions.length] = InData;

        StaticSaveConfig();

        `log("PicksAndPistols: Creating new log" @ Tag, , 'PAP');
        `log(Message, , Tag);
    }
}
