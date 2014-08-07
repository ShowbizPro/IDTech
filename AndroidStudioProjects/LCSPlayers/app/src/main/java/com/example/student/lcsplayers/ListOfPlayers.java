package com.example.student.lcsplayers;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Objects;


public class ListOfPlayers extends Activity {
    static ArrayList<String> playerNamesNA;
    static ArrayList<String> playerNamesEU;
    static ListView list;
    static CustomArrayAdapter adapter;
    AlertDialog.Builder builder;
    AlertDialog refreshed;

    SharedPreferences pref;
    static boolean NA = true;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_view);
        list = (ListView)findViewById(R.id.list);
        pref = getSharedPreferences(getPackageName(), Context.MODE_PRIVATE);

        //fills the "playerNamesNA" array with the names of all the players
        playerNamesNA = new ArrayList<String>();
        playerNamesEU = new ArrayList<String>();
        fillNames();

        //sets the adapter for the list to the custom one
        if(NA) {
            adapter = new CustomArrayAdapter(this, playerNamesNA);
        }
        else{
            adapter = new CustomArrayAdapter(this, playerNamesEU);
        }
        list.setAdapter(adapter);

        builder = new AlertDialog.Builder(ListOfPlayers.this);

        refreshed = builder.setMessage("This information was refreshed").setNeutralButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                refreshed.dismiss();
            }
        }).create();

       //calls the onClickListener to select the index, also Intenting it to the other activity, carrying over the index int
        clickItem();

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.list_view, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.NA) {
            NA = true;
            Intent intent = new Intent(ListOfPlayers.this, ListOfPlayers.class);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            return true;
        }
        if (id == R.id.EU) {
            NA = false;
            Intent intent = new Intent(ListOfPlayers.this, ListOfPlayers.class);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            return true;
        }
        if(id == R.id.refresh){
            refresh();
            refreshed.show();
        }
        return super.onOptionsItemSelected(item);
    }

    public void fillNames(){

        playerNamesNA.add("dexter-0");
        playerNamesNA.add("Meteos");
        playerNamesNA.add("NoName");
        playerNamesNA.add("Amazing");
        playerNamesNA.add("Crumbzz");
        playerNamesNA.add("Helios");
        playerNamesNA.add("kez");
        playerNamesNA.add("IWillDominate");
        playerNamesNA.add("Doublelift");
        playerNamesNA.add("Sneaky");
        playerNamesNA.add("Vasilii");
        playerNamesNA.add("WildTurtle");
        playerNamesNA.add("Imaqtpie");
        playerNamesNA.add("Altec");
        playerNamesNA.add("ROBERTxLEE");
        playerNamesNA.add("Cop");
        playerNamesNA.add("Link");
        playerNamesNA.add("Hai");
        playerNamesNA.add("XiaoWeiXiao");
        playerNamesNA.add("Bjergsen");
        playerNamesNA.add("Shiphtur");
        playerNamesNA.add("Pobelter");
        playerNamesNA.add("pr0lly");
        playerNamesNA.add("Voyboy");
        playerNamesNA.add("Aphromoo");
        playerNamesNA.add("LemonNation");
        playerNamesNA.add("Mor");
        playerNamesNA.add("Lustboy");
        playerNamesNA.add("KiWiKiD");
        playerNamesNA.add("Krepo");
        playerNamesNA.add("Bubbadub");
        playerNamesNA.add("Xpecial");
        playerNamesNA.add("Seraph");
        playerNamesNA.add("Balls");
        playerNamesNA.add("ackerman");
        playerNamesNA.add("Dyrus");
        playerNamesNA.add("Zion-Spartan");
        playerNamesNA.add("InnoX-0");
        playerNamesNA.add("Westrice");
        playerNamesNA.add("Quas");

        Collections.sort(playerNamesNA, new SortIgnoreCase());


        playerNamesEU.add("Shook");
        playerNamesEU.add("Cyanide");
        playerNamesEU.add("Kottenx");
        playerNamesEU.add("Jankos");
        playerNamesEU.add("Svenskeren");
        playerNamesEU.add("Impaler");
        playerNamesEU.add("Airwaks");
        playerNamesEU.add("Diamond");
        playerNamesEU.add("Tabzz");
        playerNamesEU.add("Rekkles");
        playerNamesEU.add("Creaton");
        playerNamesEU.add("Celaver-0");
        playerNamesEU.add("CandyPanda");
        playerNamesEU.add("MrRalleZ");
        playerNamesEU.add("Woolite");
        playerNamesEU.add("Genja");
        playerNamesEU.add("Froggen");
        playerNamesEU.add("xPeke");
        playerNamesEU.add("Kerp");
        playerNamesEU.add("Overpow");
        playerNamesEU.add("Jesiz");
        playerNamesEU.add("SELFIE");
        playerNamesEU.add("cowTard-0");
        playerNamesEU.add("niQ-0");
        playerNamesEU.add("Nyph");
        playerNamesEU.add("YellOwStaR");
        playerNamesEU.add("Jree");
        playerNamesEU.add("VandeR");
        playerNamesEU.add("nRated");
        playerNamesEU.add("kaSing");
        playerNamesEU.add("Unlimited-0");
        playerNamesEU.add("EDward");
        playerNamesEU.add("Wickd");
        playerNamesEU.add("sOAZ");
        playerNamesEU.add("Kev1n");
        playerNamesEU.add("Xaxus");
        playerNamesEU.add("fredy122");
        playerNamesEU.add("Mimer");
        playerNamesEU.add("YoungBuck-0");
        playerNamesEU.add("Kubon");

        Collections.sort(playerNamesEU, new SortIgnoreCase());
    }

    public void clickItem(){
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(ListOfPlayers.this, PlayerView.class);
                intent.putExtra("index", i);
                intent.putExtra("NameNA", playerNamesNA);
                intent.putExtra("NameEU", playerNamesEU);
                startActivity(intent);
                overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
            }
        });
    }

    public class SortIgnoreCase implements Comparator<Object> {
        public int compare(Object o1, Object o2) {
            String s1 = (String) o1;
            String s2 = (String) o2;
            return s1.toLowerCase().compareTo(s2.toLowerCase());
        }
    }

    public void refresh(){
        pref.edit().clear().commit();
    }
}
