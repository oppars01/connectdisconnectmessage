#include <sourcemod>
#include <multicolors>
#include <csgoturkiye>
#include <geoip>

#pragma semicolon 1

public Plugin myinfo = 
{
	name = "Connect Disconnect Message", 
	author = "oppa", 
	description = "Server Player Connect and Disconnect Chat Message", 
	version = "1.0", 
	url = "csgo-turkiye.com"
};

public void OnMapStart()
{
    LoadTranslations("csgotr-connect_disconnect_message.phrases.txt");
}

public void OnClientPostAdminCheck(int client){
    ChatMessage(client);
}

public void OnClientDisconnect(int client)
{
    ChatMessage(client, false);
}

void ChatMessage(int client, bool login = true){
    if(IsValidClient(client)){
        char s_username[32], s_steam_id[32], s_ip[16], s_country[128];
        if(!GetClientAuthId(client, AuthId_Steam2, s_steam_id, sizeof(s_steam_id)))Format(s_steam_id, sizeof(s_steam_id), "%t", "Unknown Steam ID"); 
        if(!GetClientName(client, s_username, sizeof(s_username)))Format(s_username, sizeof(s_username), "%t", "Unnamed");
        if(GetClientIP(client, s_ip, sizeof(s_ip), true)){
            if (!GeoipCountry(s_ip, s_country, sizeof(s_country)))Format(s_country, sizeof(s_country), "%t", "Unknown Country"); 
        }else Format(s_country, sizeof(s_country), "%t", "Unknown Country"); 
        if(login) CPrintToChatAll("%t", "Connect Message", s_steam_id, s_username, s_country);
        else CPrintToChatAll("%t", "Disconnect Message", s_steam_id, s_username, s_country, RoundToCeil(GetClientTime(client)/60));
    }
}