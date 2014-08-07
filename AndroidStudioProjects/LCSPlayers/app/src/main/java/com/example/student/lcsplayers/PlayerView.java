package com.example.student.lcsplayers;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.support.v4.app.NavUtils;

import org.jsoup.Jsoup;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;

/**
 * Created by Student on 7/31/14.
 */
public class PlayerView extends Activity {

     TextView ign;
     TextView name;
     TextView position;
     TextView team;
     TextView avgKDA;
     TextView avgGPM;
     TextView avgTG;
     TextView KDATitle;
     TextView GPMTitle;
     TextView TGTitle;
     TextView bioTitle;
     TextView bioText;
     ScrollView bio;
     ImageView photo;
     ImageView loadPhoto;
     AlertDialog facebookGone;
     AlertDialog twitterGone;
     RelativeLayout playerInfo;
     PlayerStats PS;
     int index;
     AlertDialog.Builder builder;
     ArrayList<String> names;
     SharedPreferences pref;

    GrabTask gt;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.player_info);

        pref = getSharedPreferences(getPackageName(), Context.MODE_PRIVATE);
        //initiates all the textviews and all other views
        initiate();

        //gains the intent from ListOfPlayers and sets a static variable to that value so that it can be used from within a different class
        Intent intent = getIntent();
        index = intent.getExtras().getInt("index");
         names = intent.getExtras().getStringArrayList("NameNA");

        if(ListOfPlayers.NA) {
            grabTheData(ListOfPlayers.playerNamesNA.get(index), "na");
        }
        else{
            grabTheData(ListOfPlayers.playerNamesEU.get(index), "eu");
        }

        builder = new AlertDialog.Builder(PlayerView.this);




        //makes teh bg black and all the text white(looks cleaner)
        inverseColor();

        //allows the back button to go back to ListOfPlayers
        getActionBar().setDisplayHomeAsUpEnabled(true);





    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.player_list, menu);
        return true;
    }

    public void initiate(){
        ign = (TextView)findViewById(R.id.ign);
        name = (TextView)findViewById(R.id.Name);
        position = (TextView)findViewById(R.id.Position);
        team = (TextView)findViewById(R.id.Team);
        avgKDA = (TextView)findViewById(R.id.KDAValue);
        avgGPM = (TextView)findViewById(R.id.GPMValue);
        avgTG = (TextView)findViewById(R.id.TGValue);
        bio = (ScrollView)findViewById(R.id.bio);
        photo = (ImageView)findViewById(R.id.photo);
        playerInfo = (RelativeLayout)findViewById(R.id.playerInfo);
        KDATitle = (TextView)findViewById(R.id.avgKDA);
        GPMTitle = (TextView)findViewById(R.id.avgGPM);
        TGTitle = (TextView)findViewById(R.id.avgTG);
        bioTitle = (TextView)findViewById(R.id.BIOTitle);
        bioText = (TextView)findViewById(R.id.BIOText);
        loadPhoto = (ImageView)findViewById(R.id.bg);
        loadPhoto.setBackground(getResources().getDrawable(R.drawable.aa));

    }

    public void inverseColor(){
        ign.setTextColor(getResources().getColor(android.R.color.white));
        name.setTextColor(getResources().getColor(android.R.color.white));
        team.setTextColor(getResources().getColor(android.R.color.white));
        position.setTextColor(getResources().getColor(android.R.color.white));
        avgGPM.setTextColor(getResources().getColor(android.R.color.white));
        avgKDA.setTextColor(getResources().getColor(android.R.color.white));
        avgTG.setTextColor(getResources().getColor(android.R.color.white));
        KDATitle.setTextColor(getResources().getColor(android.R.color.white));
        GPMTitle.setTextColor(getResources().getColor(android.R.color.white));
        TGTitle.setTextColor(getResources().getColor(android.R.color.white));
        bioTitle.setTextColor(getResources().getColor(android.R.color.white));
        bioText.setTextColor(getResources().getColor(android.R.color.white));
        playerInfo.setBackgroundColor(getResources().getColor(android.R.color.black));

    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        if(ListOfPlayers.NA) {
            PS = Global.naPlayers[index];
        }
        else{
            PS = Global.euPlayers[index];
        }
        int id = item.getItemId();
        if(id == R.id.twitter) {
            Intent intent = new Intent(Intent.ACTION_DEFAULT);

            if (!PS.twitter.equals("")) {
                intent.setData(Uri.parse(PS.twitter));
                startActivity(intent);
            }
            else{
                twitterGone = builder.setTitle("Sorry").setMessage("They don't have a twitter page shared").setNeutralButton("OK", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                    }
                }).create();
                twitterGone.show();
            }
            return true;
        }
        if(id == R.id.facebook) {
            Intent intent = new Intent(Intent.ACTION_DEFAULT);
            if (!PS.facebook.equals("")) {
                intent.setData(Uri.parse(PS.facebook));
                startActivity(intent);
            }
            else{
                facebookGone = builder.setTitle("Sorry").setMessage("They don't have a facebook page shared").setNeutralButton("OK", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                    }
                }).create();
                facebookGone.show();
            }

            return true;
        }
        if(id == R.id.montage){
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(Uri.parse(getVid(PS.ign)));
            startActivity(intent);
        }

        switch (item.getItemId()) {
            case android.R.id.home:
                NavUtils.navigateUpFromSameTask(this);
                overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
                return true;
        }
        return super.onOptionsItemSelected(item);
    }




    public void fillInfo(){
        if(ListOfPlayers.NA) {
            PS = Global.naPlayers[index];
        }
        else{
            PS = Global.euPlayers[index];
        }
        ign.setText(PS.ign);
        name.setText(PS.name);
        position.setText(PS.position);
        avgKDA.setText(PS.avgKDA);
        avgGPM.setText(PS.avgGPM);
        avgTG.setText(PS.avdTG);
        bioText.setText(PS.bioText);
        team.setText(PS.team);
        KDATitle.setText("Average KDA ratio:");
        GPMTitle.setText("Average Gold per Minute:");
        TGTitle.setText("Average Total Gold:");
        bioTitle.setText("Biography");
        photo.setImageBitmap(PS.photo);
    }
    public void grabTheData(String name, String regi){
        gt = new GrabTask(name, regi);
        if (ListOfPlayers.NA) {
            gt.execute();
        }
        else{
            gt.execute();
        }

    }

    public String getVid(String nam){
        String vidUrl = "";
                if(nam.equals("dexter-0")){
            vidUrl = "https://www.youtube.com/watch?v=advxwChJajQ";
        }
        else if(nam.equals("Meteos")){
            vidUrl = "https://www.youtube.com/watch?v=sF6ashOl4AI";
        }
        else if(nam.equals("NoName")){
            vidUrl = "https://www.youtube.com/watch?v=GxCELqfCFq0";
        }
        else if(nam.equals("Amazing")){
            vidUrl = "https://www.youtube.com/watch?v=g5SsEVSJ7x0";
        }
        else if(nam.equals("Crumbzz")){
            vidUrl = "https://www.youtube.com/watch?v=GE5e0TyDcMY";
        }
        else if(nam.equals("Helios")){
            vidUrl = "https://www.youtube.com/watch?v=k1g8MeqI53E";
        }
        else if(nam.equals("kez")){
            vidUrl = "https://www.youtube.com/watch?v=0-qB0WXBcH0";
        }
        else if(nam.equals("IWillDominate")){
            vidUrl = "https://www.youtube.com/watch?v=RctLhfyoyi0";
        }
        else if(nam.equals("Doublelift")){
            vidUrl = "https://www.youtube.com/watch?v=sM9B_5L5bg4";
        }
        else if(nam.equals("Sneaky")){
            vidUrl = "https://www.youtube.com/watch?v=Ca6enpfYUyA";
        }
        else if(nam.equals("Vasilii")){
            vidUrl = "https://www.youtube.com/watch?v=SgXwXvNrTck";
        }
        else if(nam.equals("WildTurtle")){
            vidUrl = "https://www.youtube.com/watch?v=hzqfijBMPLY";
        }
        else if(nam.equals("Imaqtpie")){
            vidUrl = "https://www.youtube.com/watch?v=RIniYy8Eay4";
        }
        else if(nam.equals("Altec")){
            vidUrl = "https://www.youtube.com/watch?v=THKPggsr8uo";
        }
        else if(nam.equals("ROBERTxLEE")){
            vidUrl = "https://www.youtube.com/watch?v=e_ILCFLbhVA";
        }
        else if(nam.equals("Cop")){
            vidUrl = "https://www.youtube.com/watch?v=Qs5_VCK5vm4";
        }
        else if(nam.equals("Link")){
            vidUrl = "https://www.youtube.com/watch?v=bcObNlLjwpA";
        }
        else if(nam.equals("Hai")){
            vidUrl = "https://www.youtube.com/watch?v=zo3eKqfGko8";
        }
        else if(nam.equals("XiaoWieXiao")){
            vidUrl = "https://www.youtube.com/watch?v=xWqioSTHlTw";
        }
        else if(nam.equals("Bjergsen")){
            vidUrl = "https://www.youtube.com/watch?v=iFeR4hBXzJ0";
        }
        else if(nam.equals("Shiphtur")){
            vidUrl = "https://www.youtube.com/watch?v=3k6LxLVPEmI";
        }
        else if(nam.equals("Pobelter")){
            vidUrl = "https://www.youtube.com/watch?v=Z-nW0AH4kfA";
        }
        else if(nam.equals("pr0lly")){
            vidUrl = "https://www.youtube.com/watch?v=lx2BrJ_TZmY";
        }
        else if(nam.equals("Voyboy")){
            vidUrl = "https://www.youtube.com/watch?v=LhYduD8A8rw";
        }
        else if(nam.equals("Aphromoo")){
            vidUrl = "https://www.youtube.com/watch?v=naqA_3B0y3k";
        }
        else if(nam.equals("LemonNation")){
            vidUrl = "https://www.youtube.com/watch?v=mSZsUrZUQMM";
        }
        else if(nam.equals("Mor")){
            vidUrl = "https://www.youtube.com/watch?v=ozitD5Fpn-Y";
        }
        else if(nam.equals("Lustboy")){
            vidUrl = "https://www.youtube.com/watch?v=zVnnwcVqO9w";
        }
        else if(nam.equals("KiWiKiD")){
            vidUrl = "https://www.youtube.com/watch?v=lsUOKd2DBeQ";
        }
        else if(nam.equals("Krepo")){
            vidUrl = "https://www.youtube.com/watch?v=NCQm0bRohbU";
        }
        else if(nam.equals("Bubbadub")){
            vidUrl = "https://www.youtube.com/watch?v=NDkrB6H7ybw";
        }
        else if(nam.equals("Xpecial")){
            vidUrl = "https://www.youtube.com/watch?v=EctLr8slqZI";
        }
        else if(nam.equals("Seraph")){
            vidUrl = "https://www.youtube.com/watch?v=ydry9eEGHCc";
        }
        else if(nam.equals("Balls")){
            vidUrl = "https://www.youtube.com/watch?v=odpGRlXEJoA";
        }
        else if(nam.equals("ackerman")){
            vidUrl = "https://www.youtube.com/watch?v=eUpIjJjiHPM";
        }
        else if(nam.equals("Dyrus")){
            vidUrl = "https://www.youtube.com/watch?v=rvlCxuKkUQw";
        }
        else if(nam.equals("Zion-Spartan")){
            vidUrl = "https://www.youtube.com/watch?v=iYg0rSgqWiY";
        }
        else if(nam.equals("InnoX-0")){
            vidUrl = "https://www.youtube.com/watch?v=bvW6kcGjBWw";
        }
        else if(nam.equals("Westrice")){
            vidUrl = "https://www.youtube.com/watch?v=Ctq04bk8qE4";
        }
        else if(nam.equals("Quas")){
            vidUrl = "https://www.youtube.com/watch?v=c4WNUQaKPGU";
        }
        else if(nam.equals("Shook")){
            vidUrl = "https://www.youtube.com/watch?v=LH7wUlFLGTI";
        }
        else if(nam.equals("Cyanide")){
            vidUrl = "https://www.youtube.com/watch?v=waK9Og1izAk";
        }
        else if(nam.equals("Kottenx")){
            vidUrl = "https://www.youtube.com/watch?v=IbUothLOwh0";
        }
        else if(nam.equals("Jankos")){
            vidUrl = "https://www.youtube.com/watch?v=6UmEIhZwHyg";
        }
        else if(nam.equals("Svenskeren")){
            vidUrl = "https://www.youtube.com/watch?v=tbmZT4XXrFo";
        }
        else if(nam.equals("Impaler")){
            vidUrl = "https://www.youtube.com/watch?v=od8dowaa0k0";
        }
        else if(nam.equals("Airwaks")){
            vidUrl = "https://www.youtube.com/watch?v=Z_LBA6_vBhc";
        }
        else if(nam.equals("Diamond")){
            vidUrl = "https://www.youtube.com/watch?v=MDNiY0sEcCY";
        }
        else if(nam.equals("Tabzz")){
            vidUrl = "https://www.youtube.com/watch?v=FF8J7qPVrl4";
        }
        else if(nam.equals("Rekkles")){
            vidUrl = "https://www.youtube.com/watch?v=TKLvM8myk9k";
        }
        else if(nam.equals("Creaton")){
            vidUrl = "https://www.youtube.com/watch?v=-99qN0VgMew";
        }
        else if(nam.equals("Celaver-0")){
            vidUrl = "https://www.youtube.com/watch?v=Q9mu4tubb8I";
        }
        else if(nam.equals("CandyPanda")){
            vidUrl = "https://www.youtube.com/watch?v=ZjgSkoyuQqE";
        }
        else if(nam.equals("MrRalleZ")){
            vidUrl = "https://www.youtube.com/watch?v=oYeHvlaXtSA";
        }
        else if(nam.equals("Woolite")){
            vidUrl = "https://www.youtube.com/watch?v=J8IjxLR0D98";
        }
        else if(nam.equals("Genja")){
            vidUrl = "https://www.youtube.com/watch?v=Zho0pbieNQc";
        }
        else if(nam.equals("Froggen")){
            vidUrl = "https://www.youtube.com/watch?v=yMoamtr5Jto";
        }
        else if(nam.equals("xPeke")){
            vidUrl = "https://www.youtube.com/watch?v=87gmcgsGvIU";
        }
        else if(nam.equals("Kerp")){
            vidUrl = "https://www.youtube.com/watch?v=rRKhXphBSPM";
        }
        else if(nam.equals("Overpow")){
            vidUrl = "https://www.youtube.com/watch?v=n03PkxhSyPw";
        }
        else if(nam.equals("Jesiz")){
            vidUrl = "https://www.youtube.com/watch?v=N5usgmyXEvw";
        }
        else if(nam.equals("SELFIE")){
            vidUrl = "https://www.youtube.com/watch?v=DaftXM49Iu0";
        }
        else if(nam.equals("cowTard-0")){
            vidUrl = "https://www.youtube.com/watch?v=nof6wp8iCsY";
        }
        else if(nam.equals("niQ-0")){
            vidUrl = "https://www.youtube.com/watch?v=XFRZJt_uwqs";
        }
        else if(nam.equals("Nyph")){
            vidUrl = "https://www.youtube.com/watch?v=2KNcFuTjjGc";
        }
        else if(nam.equals("YellOwStaR")){
            vidUrl = "https://www.youtube.com/watch?v=yDYfwUt1f5c";
        }
        else if(nam.equals("Jree")){
            vidUrl = "https://www.youtube.com/watch?v=jnM25hC0Yts";
        }
        else if(nam.equals("VandeR")){
            vidUrl = "https://www.youtube.com/watch?v=FHYBhLPtiBY";
        }
        else if(nam.equals("nRated")){
            vidUrl = "https://www.youtube.com/watch?v=BN9wdeVN37o";
        }
        else if(nam.equals("kaSing")){
            vidUrl = "https://www.youtube.com/watch?v=BP0HmNZmgxo";
        }
        else if(nam.equals("Unlimited-0")){
            vidUrl = "https://www.youtube.com/watch?v=XbVg9yRoDp4";
        }
        else if(nam.equals("EDward")){
            vidUrl = "https://www.youtube.com/watch?v=fgC6LCMCf5s";
        }
        else if(nam.equals("Wickd")){
            vidUrl = "https://www.youtube.com/watch?v=C6-KbK_0T34";
        }
        else if(nam.equals("sOAZ")){
            vidUrl = "https://www.youtube.com/watch?v=wL8HJJ2Y0nw";
        }
        else if(nam.equals("Kev1n")){
            vidUrl = "https://www.youtube.com/watch?v=YPLkeERX5ls";
        }
        else if(nam.equals("Xaxus")){
            vidUrl = "https://www.youtube.com/watch?v=yyfxx5fnzyU";
        }
        else if(nam.equals("fredy122")){
            vidUrl = "https://www.youtube.com/watch?v=dLC3heObhv0";
        }
        else if(nam.equals("Mimer")){
            vidUrl = "https://www.youtube.com/watch?v=1rQKdSkOLQE";
        }
        else if(nam.equals("YoungBuck-0")){
            vidUrl = "https://www.youtube.com/watch?v=TMHx6yYHECE";
        }
        else if(nam.equals("Kubon")){
            vidUrl = "https://www.youtube.com/watch?v=0wK6GJlYO1c";
        }



        return vidUrl;
    }


    public class GrabTask extends AsyncTask {
        String nam;
        String reg;
        public GrabTask(String name, String region){
            nam = name;
            reg = region;
        }



        @Override
        protected Object doInBackground(Object[] objects) {


            grabData(nam, reg);
            return null;

        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            loadPhoto.setVisibility(View.VISIBLE);
         }

        public PlayerStats grabData(String playerName, String region) {
            PlayerStats PS = new PlayerStats();

            String ign = pref.getString("IGN "+playerName, "null");
            String name = pref.getString("Name "+playerName, "null");
            String team = pref.getString("Team "+playerName, "null");
            String position = pref.getString("Position "+playerName, "null");
            String avgKDA = pref.getString("avgKDA "+playerName, "null");
            String avgGPM = pref.getString("avgGPM "+playerName, "null");
            String avgTG = pref.getString("avgTG "+playerName, "null");
            String photoURL = pref.getString("photoURL "+playerName, "null");
            String bio = pref.getString("bio "+playerName, "null");
            if(!ign.equals("null")){
                PS.ign = ign;
                PS.name = name;
                PS.team = team;
                PS.position = position;
                PS.avgKDA = avgKDA;
                PS.avgGPM = avgGPM;
                PS.avdTG = avgTG;
                PS.bioText = bio;
                makePhoto(photoURL, PS);
            }
            else {

                String url = "http://na.lolesports.com/" + region + "-lcs/2014/split2/players/" + playerName;
                try {
                    org.jsoup.nodes.Document document = Jsoup.connect(url).get();

                    //grabs the players personal information using the css path
                    getInfo(document, PS);

                    //grabs the stats of the player using the css path
                    getStats(document, PS);

                    //grabs the bio of the player
                    getBio(document, PS);

                    //grabs the photoBitmap of the player
                    getPhoto(document, PS);

                    //gets the team of the players(not available on the site otehr than image)
                    getTeam(playerName, PS);

                    //gets social media
                    getTwitter(document, PS);
                    getFacebook(document, PS);


                    saveData(PS);
                }
                catch (IOException e){
                }

            }

            if(region.equals("na")) {
                Global.naPlayers[index] = PS;
            }
            else{
                Global.euPlayers[index]=  PS;
            }

            return PS;
        }

        @Override
        protected void onPostExecute(Object o) {
            super.onPostExecute(o);
            loadPhoto.setVisibility(View.INVISIBLE);
            fillInfo();
        }

        public void getInfo(org.jsoup.nodes.Document document, PlayerStats PS){
            Elements ignDes = document.select("span[class=field-content player-summoner-name]");
            String s = ignDes.html().toString();
            s = s.replace("&quot;", "");
            PS.ign = s;

            Elements nameDes = document.select("span[class=field-content player-first-name]");
            String first = nameDes.html().toString();
            Elements lastNameDes = document.select("span[class=field-content player-last-name]");
            String last = lastNameDes.html().toString();
            PS.name = first.concat(" ").concat(last);
            if (PS.name.contains("&uuml;")){
               PS.name = PS.name.replace("&uuml;", "ü");
            }
            if (PS.name.contains("&oslash;")){
               PS.name = PS.name.replace("&oslash;", "ø");
            }
            if (PS.name.contains("&ntilde;")){
                PS.name = PS.name.replace("&ntilde;", "ñ");
            }
            if (PS.name.contains("&iacute;")){
                PS.name = PS.name.replace("&iacute;", "í");
            }



            Elements posDes = document.select("span[class=field-content player-position]");
            PS.position = posDes.html().toString();
        }

        public void getStats(org.jsoup.nodes.Document document, PlayerStats PS){
            for(int i = 1; i < 4; i++) {
                String path1 = "#player-profile > div.panel-panel.panel-col-top.pro-kit-dark-wrapper.pro-kit-dark-wrapper-bottom > div > div > div.panel-pane.pane-panels-mini.pane-player-more-info > div > div.panel-panel.panel-col-first > div > div > div > div > ul > li:nth-child(";
                String path2 = ") > div.stat-value";
                Elements kdaDes = document.select(path1.concat(i+"").concat(path2));
                if(i == 1){
                    PS.avgKDA = kdaDes.html().toString();
                }
                else if(i == 2){
                    PS.avgGPM = kdaDes.html().toString();
                }
                else{
                    PS.avdTG = kdaDes.html().toString();
                }
            }
        }

        public void getBio(org.jsoup.nodes.Document document, PlayerStats PS){
            Elements bioDes = document.select("#player-profile > div.center-wrapper.pro-kit-light-wrapper > div > div.center-wrapper-inner.page > div.panel-panel.panel-col-first > div > div > div > div > div");
            String j = bioDes.html().toString();
            j = j.replace("<p>", "");
            j = j.replace("</p>", "");
            j = j.replace("&quot;", "\"");
            if (j.equals("")){
                j = "N/A";
            }
            if (j.contains("&uuml;")){
                j = j.replace("&uuml;", "ü");
            }
            if (j.contains("&oslash;")){
                j = j.replace("&oslash;", "ø");
            }
            PS.bioText =j;
        }

        public void getPhoto(org.jsoup.nodes.Document document, PlayerStats PS){
            Elements photoDes = document.select("#player-profile > div.panel-panel.panel-col-featured > div > div > div > div > div > div > div.player-profile-background > div > div > div");
            String r = photoDes.html().toString();
            r = r.replace("<img src=\"", "");
            r = r.replace("\" width=\"580\" height=\"400\" alt=\"\" title=\"\" />", "");
            String na = "http://na.lolesports.com";
            r = na.concat(r);
            PS.photoURL = r;
            makePhoto(PS.photoURL, PS);
        }

        public void getTeam(String name, PlayerStats PS){
            if(name.equals("Dyrus") || name.equals("Amazing") || name.equals("Bjergsen") || name.equals("WildTurtle") || name.equals("Lustboy")){
                PS.team = "Team SoloMid";
            }
            if(name.equals("Zion-Spartan") || name.equals("Crumbzz") || name.equals("Shiphtur") || name.equals("Imaqtpie") || name.equals("KiWiKiD")){
                PS.team = "Team Dignitas";
            }
            if(name.equals("ackerman") || name.equals("NoName") || name.equals("XiaoWieXiao") || name.equals("Vasilii") || name.equals("Mor")){
                PS.team = "LMQ";
            }
            if(name.equals("InnoX-0") || name.equals("Helios") || name.equals("Pobelter") || name.equals("Altec") || name.equals("Krepo")){
                PS.team = "Evil Geniuses";
            }
            if(name.equals("Quas") || name.equals("IWillDominate") || name.equals("Voyboy") || name.equals("Cop") || name.equals("Xpecial")){
                PS.team = "Curse";
            }
            if(name.equals("Seraph") || name.equals("dexter-0") || name.equals("Link") || name.equals("Doublelift") || name.equals("Aphromoo")){
                PS.team = "Counter Logic Gaming";
            }
            if(name.equals("Balls") || name.equals("Meteos") || name.equals("Hai") || name.equals("Sneaky") || name.equals("LemonNation")){
                PS.team = "Cloud9";
            }
            if(name.equals("Westrice") || name.equals("kez") || name.equals("pr0lly") || name.equals("ROBERTxLEE") || name.equals("Bubbadub")){
                PS.team = "compLexity";
            }


            if(name.equals("Nyph") || name.equals("Tabzz") || name.equals("Froggen") || name.equals("Shook") || name.equals("Wickd")){
                PS.team = "Alliance";
            }
            if(name.equals("YoungBuck-0") || name.equals("Airwaks") || name.equals("cowTard-0") || name.equals("Woolite") || name.equals("Unlimited-0")){
                PS.team = "Copenh";
            }
            if(name.equals("sOAZ") || name.equals("Cyanide") || name.equals("xPeke") || name.equals("Rekkles") || name.equals("YellOwStaR")){
                PS.team = "Fnatic";
            }
            if(name.equals("Kubon") || name.equals("Diamond") || name.equals("niQ-0") || name.equals("Genja") || name.equals("Edward")){
                PS.team = "Gambit Gaming";
            }
            if(name.equals("Kev1n") || name.equals("Kottenx") || name.equals("Kerp") || name.equals("Creaton") || name.equals("Jree")){
                PS.team = "Millenium";
            }
            if(name.equals("Xaxus") || name.equals("Jankos") || name.equals("Overpow") || name.equals("Celaver-0") || name.equals("VandeR")){
                PS.team = "Roccat";
            }
            if(name.equals("fredy122") || name.equals("Svenskeren") || name.equals("Jezis") || name.equals("CandyPanda") || name.equals("nRated")){
                PS.team = "SK Gaming";
            }
            if(name.equals("Mimer") || name.equals("Impaler") || name.equals("SELFIE") || name.equals("MrRalleZ") || name.equals("kaSing")){
                PS.team = "Supa Hot Crew";
            }

        }

        public void getTwitter(org.jsoup.nodes.Document document, PlayerStats PS){
            Elements twitterDes = document.select("#player-profile > div.panel-panel.panel-col-featured > div > div > div > div > div > div > div.player-profile-foreground > div.player-profile-social > div:nth-child(1) > a");
            PS.twitter = twitterDes.toString();
            PS.twitter = PS.twitter.replace("<a href=\"", "");
            PS.twitter = PS.twitter.replace("\" class=\"twitter-link\" target=\"_blank\">Twitter</a>", "");
        }

        public void getFacebook(org.jsoup.nodes.Document document, PlayerStats PS){
            Elements faceDes = document.select("#player-profile > div.panel-panel.panel-col-featured > div > div > div > div > div > div > div.player-profile-foreground > div.player-profile-social > div:nth-child(2) > a");
            PS.facebook = faceDes.toString();
            PS.facebook = PS.facebook.replace("<a href=\"", "");
            PS.facebook = PS.facebook.replace("\" class=\"facebook-link\" target=\"_blank\">Facebook</a>", "");
        }

        public void saveData(PlayerStats PS){
            pref.edit().putString("IGN " + PS.ign, PS.ign).commit();
            pref.edit().putString("Name " + PS.ign, PS.name).commit();
            pref.edit().putString("Position " + PS.ign, PS.position).commit();
            pref.edit().putString("Team " + PS.ign, PS.team).commit();
            pref.edit().putString("avgKDA " + PS.ign, PS.avgKDA).commit();
            pref.edit().putString("avgGPM " + PS.ign, PS.avgGPM).commit();
            pref.edit().putString("avgTG " + PS.ign, PS.avdTG).commit();
            pref.edit().putString("photoURL " + PS.ign, PS.photoURL).commit();
            pref.edit().putString("bio " + PS.ign, PS.bioText).commit();

        }

        public void makePhoto(String r, PlayerStats PS){
            try {
                InputStream in = new URL(r).openStream();
                Bitmap bmp = BitmapFactory.decodeStream(in);
                PS.photo = bmp;
            }
            catch(IOException e){
                Log.v("Error at makePhoto", e.getMessage());
            }
        }


    }



}
