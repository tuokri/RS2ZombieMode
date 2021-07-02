// TODO: Should we also manage raw cues (without components)?
class ZMAudioManager extends Object
    config(Mutator_ZombieMode_Client);

// NOTE: ZMAudioComponents shouldn't use EAC_MASTER as their audio class.
// TODO: Announcer volume?
enum EAudioClass
{
    EAC_MASTER,
    EAC_SFX,
    EAC_MUSIC,
};

// SFX or Music should always be preferred over Master,
// but it's here as a fallback option.
var array<ZMAudioComponent> MasterComponents;
var array<ZMAudioComponent> SFXComponents;
var array<ZMAudioComponent> MusicComponents;

var config float MasterVolume;
var config float SFXVolume;
var config float MusicVolume;


function InitSoundClassVolumes()
{
    local AudioDevice AD;

    AD = class'Engine'.static.GetAudioDevice();

    if (AD != None)
    {
        MasterVolume = AD.AkMasterVolume;
        SFXVolume = AD.AkSFXVolume;
        MusicVolume = AD.AkMusicVolume;
        SaveConfig();
    }
}

// Audio class volume adjusted by master volume.
function float GetAdjustedAudioClassVolume(EAudioClass AudioClass)
{
    switch (AudioClass)
    {
        case EAC_MASTER:
            return MasterVolume;
        case EAC_SFX:
            return SFXVolume * MasterVolume;
        case EAC_MUSIC:
            return MusicVolume * MasterVolume;
        default:
            `warn("GetAudioClassVolume: invalid audio class: " $ AudioClass);
            return 0.2;
    }
}

function UpdateVolume(float NewVolume, EAudioClass AudioClass)
{
    local ZMAudioComponent ZMAC;

    switch (AudioClass)
    {
        case EAC_MASTER:
            MasterVolume = NewVolume;
            foreach MasterComponents(ZMAC)
            {
                ZMAC.AdjustVolume(0.1, MasterVolume);
                // `log("Adjusting " $ ZMAC $ " MasterVolume = " $ MasterVolume);
            }
            // Need to also update other classes if master is changed.
            UpdateVolume(SFXVolume, EAC_SFX);
            UpdateVolume(MusicVolume, EAC_MUSIC);
            break;
        case EAC_SFX:
            SFXVolume = NewVolume;
            foreach SFXComponents(ZMAC)
            {
                ZMAC.AdjustVolume(0.1, GetAdjustedAudioClassVolume(AudioClass));
                // `log("Adjusting " $ ZMAC $ " SFXVolume = " $ SFXVolume);
            }
            break;
        case EAC_MUSIC:
            MusicVolume = NewVolume;
            foreach MusicComponents(ZMAC)
            {
                ZMAC.AdjustVolume(0.1, GetAdjustedAudioClassVolume(AudioClass));
                // `log("Adjusting " $ ZMAC $ " MusicVolume = " $ MusicVolume);
            }
            break;
        default:
            `warn("UpdateVolume: invalid audio class: " $ AudioClass);
            break;
    }

    SaveConfig();
}

// TODO: Store original volume modifier of component / cue?
function RegisterAudioComponent(const out ZMAudioComponent ZMAC)
{
    // `log(ZMAC $ " original AC VolumeMultiplier = " $ ZMAC.VolumeMultiplier);
    // `log(ZMAC.SoundCue $ " original SC VolumeMultiplier = " $ ZMAC.SoundCue.VolumeMultiplier);
    ZMAC.AdjustVolume(0.1, GetAdjustedAudioClassVolume(ZMAC.AudioClass));
    // `log(ZMAC $ " adjusted AC VolumeMultiplier = " $ ZMAC.VolumeMultiplier);
    // `log(ZMAC.SoundCue $ " original SC VolumeMultiplier = " $ ZMAC.SoundCue.VolumeMultiplier);

    `log("RegisterAudioComponent(): Component=" $ ZMAC,, 'ZombieModeAudio');

    switch (ZMAC.AudioClass)
    {
        case EAC_MASTER:
            MasterComponents.AddItem(ZMAC);
            break;
        case EAC_SFX:
            SFXComponents.AddItem(ZMAC);
            break;
        case EAC_MUSIC:
            MusicComponents.AddItem(ZMAC);
            break;
        default:
            `warn("RegisterAudioComponent: invalid audio class: " $ ZMAC.AudioClass);
            break;
    }
}
