class PAPPlayerReplicationInfo extends ROPlayerReplicationInfo;

simulated function ClientInitialize(Controller C)
{
    super.ClientInitialize(C);
    PawnHandlerClass = class'PAPPawnHandler';
}

function bool SelectRoleByClass(Controller C, class<RORoleInfo> RoleInfoClass,
    optional out WeaponSelectionInfo WeaponSelection, optional out byte NewSquadIndex,
    optional out byte NewClassIndex, optional class<ROVehicle> TankSelection)
{
    local RORoleInfo NewRoleInfo;
    local array<RORoleCount> Roles;
    local array<RORolesTaken> RolesTaken;
    local ROMapInfo ROMI;
    local ROTeamInfo ROTI;
    local bool bSuccess, bUnlimitedRoles, bRoleAvailable;
    local PAPPlayerController ROPC;
    local ROAIController ROBot;
    local Controller BootedBot;
    local int i, DesiredRoleIndex;
    local byte OldSquadIndex;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());
    DesiredRoleIndex = -1;
    NewSquadIndex = SquadIndex;
    OldSquadIndex = SquadIndex;

    if (C == none)
    {
        return false;
    }

    if (ROAIController(C) != none)
    {
        return super.SelectRoleByClass(C, RoleInfoClass, WeaponSelection, NewSquadIndex, NewClassIndex, TankSelection);
    }

    if ( ROMI != none && Team != none )
    {
        ROPC = PAPPlayerController(C);

        if( ROPC == none )
            ROBot = ROAIController(C);

        bUnlimitedRoles = class<ROGameInfo>(WorldInfo.GRI.GameClass).default.bUnlimitedRoles;

        if ( ROPC != none || ROBot != none )
        {
            // The "selected role is full" bug is caused by client/server desync with the roles, so we need to replace them here too

            ROPC.ReplaceRoles();

            if ( Team.TeamIndex == `AXIS_TEAM_INDEX )
            {
                Roles = ROMapInfo(ROPC.WorldInfo.GetMapInfo()).NorthernRoles;
                RolesTaken = ROMapInfo(ROPC.WorldInfo.GetMapInfo()).NorthernRolesTaken;
            }
            else
            {
                Roles = ROMapInfo(ROPC.WorldInfo.GetMapInfo()).SouthernRoles;
                RolesTaken = ROMapInfo(ROPC.WorldInfo.GetMapInfo()).SouthernRolesTaken;
            }

            for ( i = 0; i < Roles.Length; i++ )
            {
                if( Roles[i].RoleInfoClass.default.ClassIndex == RoleInfoClass.default.ClassIndex && (bUnlimitedRoles || RolesTaken[i].TakenByHumans < Roles[i].Count || ClassIndex == Roles[i].RoleInfoClass.default.ClassIndex) )
                {
                    bRoleAvailable = true;
                    DesiredRoleIndex = i;
                    ROTI = ROTeamInfo(Team);
                    if( RolesTaken[i].TotalTaken >= Roles[i].Count && ROTI != none )
                    {
                        for( i=0; i<`MAX_PLAYERS_PER_TEAM; i++ )
                        {
                            if( ROTI.TeamPRIArray[i] != none && ROTI.TeamPRIArray[i].bBot && ROTI.TeamPRIArray[i].ClassIndex == RoleInfoClass.default.ClassIndex )
                            {
                                BootedBot = Controller(ROTI.TeamPRIArray[i].Owner);
                                break;
                            }
                        }
                    }
                    break;
                }
            }
        }

        if ( Team.TeamIndex == `AXIS_TEAM_INDEX )
        {
            if ( !bUnlimitedRoles && RoleInfoClass.default.bIsTeamLeader )
            {
                if ( ROPC != none )
                {
                    if ( ROMI.NorthernTeamLeader.Owner == none || ROMI.NorthernTeamLeader.Owner == ROPC || AIController(ROMI.NorthernTeamLeader.Owner) != none ||
                         !ROMI.OwnerHasRole(ROMI.NorthernTeamLeader.Owner, Team.TeamIndex, `SQUAD_INDEX_TEAMLEADER, 0, WorldInfo) )
                    {
                        BootedBot = AIController(ROMI.NorthernTeamLeader.Owner);
                        ROMI.NorthernTeamLeader.Owner = ROPC;
                        NewSquadIndex = `SQUAD_INDEX_TEAMLEADER;
                        ROTeamInfo(Team).bHasTeamLeader = true;
                        bSuccess = true;
                    }
                }
                else if ( ROMI.NorthernTeamLeader.Owner == none )
                {
                    ROMI.NorthernTeamLeader.Owner = C;
                    bSuccess = true;
                }
                if ( bSuccess ) NewRoleInfo = ROMI.NorthernTeamLeader.RoleInfo;
            }
            else
            {
                Roles = ROMI.NorthernRoles;
            }
        }
        else
        {
            if ( !bUnlimitedRoles && RoleInfoClass.default.bIsTeamLeader )
            {
                if ( ROPC != none )
                {
                    if ( ROMI.SouthernTeamLeader.Owner == none || ROMI.SouthernTeamLeader.Owner == ROPC || AIController(ROMI.SouthernTeamLeader.Owner) != none ||
                         !ROMI.OwnerHasRole(ROMI.SouthernTeamLeader.Owner, Team.TeamIndex, `SQUAD_INDEX_TEAMLEADER, 0, WorldInfo) )
                    {
                        BootedBot = AIController(ROMI.SouthernTeamLeader.Owner);
                        ROMI.SouthernTeamLeader.Owner = ROPC;
                        NewSquadIndex = `SQUAD_INDEX_TEAMLEADER;
                        ROTeamInfo(Team).bHasTeamLeader = true;
                        bSuccess = true;
                    }
                }
                else if ( ROMI.SouthernTeamLeader.Owner == none )
                {
                    ROMI.SouthernTeamLeader.Owner = C;
                    NewSquadIndex = `SQUAD_INDEX_TEAMLEADER;
                    bSuccess = true;
                }
                if ( bSuccess ) NewRoleInfo = ROMI.SouthernTeamLeader.RoleInfo;
            }
            else
            {
                Roles = ROMI.SouthernRoles;
            }
        }

        if( bSuccess )
        {
            NewClassIndex = NewRoleInfo.ClassIndex;
            if( Squad != none && RoleIndex < `MAX_ROLES_PER_SQUAD )
            {
                Squad.LeaveSquad(ROPC, RoleIndex);
            }
        }
        else if ( DesiredRoleIndex > -1 && (bUnlimitedRoles || bRoleAvailable) )
        {
            NewRoleInfo = new RoleInfoClass;
            if( NewRoleInfo != none && NewRoleInfo.bIsPilot )
            {
                if( Squad != none )
                    Squad.LeaveSquad(ROPC, RoleIndex);
                NewSquadIndex = `SQUAD_INDEX_PILOT;
            }
            else if( NewSquadIndex == `SQUAD_INDEX_TEAMLEADER || NewSquadIndex == `SQUAD_INDEX_PILOT )
            {
                NewSquadIndex = `SQUAD_INDEX_NONE;
            }
        }
        if ( NewRoleInfo != none && !bSuccess )
        {
            NewClassIndex = NewRoleInfo.ClassIndex;
            bSuccess = true;
        }
    }

    if ( bSuccess )
    {
        if ( !bUnlimitedRoles && ClassIndex != NewClassIndex )
        {
            ClearRole(C);
        }

        if( ClassIndex != NewClassIndex && ROPC != none && ROPC.IsLocalPlayerController() )
        {
            ROPC.LastDisplayedClass = NewClassIndex;
            ROPC.SaveConfig();
        }

        RoleInfo = NewRoleInfo;
        ClassIndex = NewClassIndex;

        if( OldSquadIndex != NewSquadIndex )
        {
            SquadIndex = NewSquadIndex;
            if( NewSquadIndex > `MAX_SQUADS )
            {
                if( ROPC != none )
                    ROPC.ClearPurpleSmokeMarker();
            }
            if( NewSquadIndex == `SQUAD_INDEX_NONE )
            {
                if( ROPC != none )
                    ROPC.AutoSelectSquad();
            }
        }

        if ( Team.TeamIndex == `AXIS_TEAM_INDEX )
        {
            UpdateClassCount(`AXIS_TEAM_INDEX, DesiredRoleIndex);
        }
        else
        {
            UpdateClassCount(`ALLIES_TEAM_INDEX, DesiredRoleIndex);
        }

        if( Squad != none && RoleIndex < `MAX_ROLES_PER_SQUAD )
        {
            Squad.SquadMembers[RoleIndex].RoleInfo = RoleInfo;
        }

        ClassRank = 0;

        if ( WorldInfo.NetMode != NM_DedicatedServer )
        {
            ReplicatedEvent('SquadIndex');
        }

        IsWeaponIndexValid(RoleInfo, ROPlayerController(C), WeaponSelection.PrimaryWeaponIndex, WeaponSelection.SecondaryWeaponIndex);

        if (AIController(C) != None)
            WeaponSelection.PrimaryWeaponIndex = ChooseRandomPrimaryWeapon(RoleInfo, C, WeaponSelection.PrimaryWeaponIndex);

        RoleInfo.SetActiveWeaponLoadout(WeaponSelection);

        if( ROAIController(BootedBot) != none )
        {
            if( ROAIController(BootedBot).ChooseRole() )
            {
                if ( BootedBot.Pawn != none )
                {
                    BootedBot.Pawn.Suicide();
                }
            }
            else
                BootedBot.Destroy();
        }

        if ( RoleInfo.bIsTeamLeader )
        {
            if ( ROPC != none )
            {
                if ( Team.TeamIndex == `AXIS_TEAM_INDEX )
                {
                    for ( i = 0; i < ROMI.NorthernSquads.Length; i++ )
                    {
                        ROPC.SRIArray[i] = ROMI.NorthernSquads[i].SRI;
                    }
                }
                else
                {
                    for ( i = 0; i < ROMI.SouthernSquads.Length; i++ )
                    {
                        ROPC.SRIArray[i] = ROMI.SouthernSquads[i].SRI;
                    }
                }
            }
        }
        else
        {
            if ( ROPC != none )
            {
                for ( i = 0; i < `MAX_SQUADS; i++ )
                {
                    ROPC.SRIArray[i] = none;
                }
            }
        }

        if( ROGameInfo(WorldInfo.Game).bRoundHasBegun && bDead )
        {
            SpawnSelection = 0;
        }
        else
        {
            SpawnSelection = 128;
        }

        if ( Collector != none )
        {
            Collector.UpdateRole(PlayerID, (RoleInfo == none) ? 0 : INT(RoleInfo.RoleType), RoleInfo.MyName, (Team == none) ? -1 : Team.TeamIndex);
        }
    }

    if( bBot )
    {
        PawnHandlerClass = class'PAPPawnHandler';
    }

    return bSuccess;
}

function bool IsWeaponIndexValid(RORoleInfo NewRoleInfo, ROPlayerController ROPC,
    out byte PrimaryWeaponIndex, out byte SecondaryWeaponIndex)
{
    local ROGameReplicationInfo ROGRI;
    local byte AdjustedClassRank;

    AdjustedClassRank = ClassRank;
    ROGRI = ROGameReplicationInfo(WorldInfo.GRI);

    PrimaryWeaponIndex = Max(PrimaryWeaponIndex, NewRoleInfo.GetPrimaryWeaponsStart(AdjustedClassRank));

    if (!ROGRI.bNoWeaponLimits || !ROGRI.IsMultiplayerGame())
    {
        PrimaryWeaponIndex = Min(PrimaryWeaponIndex, NewRoleInfo.GetPrimaryWeaponsNum(ROGRI.RoleInfoItemsIdx, AdjustedClassRank) - 1);
    }

    SecondaryWeaponIndex = Max(SecondaryWeaponIndex, NewRoleInfo.GetSecondaryWeaponsStart(AdjustedClassRank));

    if ( ROGRI.bRealisticPistolLoadouts )
    {
        SecondaryWeaponIndex = Min(SecondaryWeaponIndex, NewRoleInfo.GetSecondaryWeaponsNum(
            ROGRI, ROGRI.RoleInfoItemsIdx, AdjustedClassRank, bIsSquadLeader, PrimaryWeaponIndex) - 1);
    }

    return True;
}

DefaultProperties
{
    PawnHandlerClass=class'PAPPawnHandler'
}
