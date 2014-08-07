package com.example.student.lcsplayers;

import java.util.ArrayList;
import com.example.student.lcsplayers.PlayerStats;

/**
 * Created by Student on 8/1/14.
 */
public class Global {
    static PlayerStats[] naPlayers = new PlayerStats[40];
    static PlayerStats[] euPlayers = new PlayerStats[40];

    public static PlayerStats[] getNaArray(){
        return naPlayers;
    }
    public static PlayerStats[] getEUArray(){
        return euPlayers;
    }

}
