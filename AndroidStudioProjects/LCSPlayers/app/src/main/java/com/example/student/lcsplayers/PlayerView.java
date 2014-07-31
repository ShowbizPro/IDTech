package com.example.student.lcsplayers;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;

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
    ScrollView bio;
    ImageView photo;
    RelativeLayout playerInfo;
    TextView bioText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.player_info);
        initiate();
        photo.setBackground(getResources().getDrawable(R.drawable.ic_launcher));
        bioText.setText("Hello");
        bio.addView(bioText, bio.getWidth(), bio.getHeight());
    }
    public void initiate(){
        ign = (TextView)findViewById(R.id.ign);
        name = (TextView)findViewById(R.id.Name);
        position = (TextView)findViewById(R.id.Position);
        team = (TextView)findViewById(R.id.Team);
        avgKDA = (TextView)findViewById(R.id.avgKDA);
        avgGPM = (TextView)findViewById(R.id.avgGPM);
        avgTG = (TextView)findViewById(R.id.avgTG);
        bio = (ScrollView)findViewById(R.id.bio);
        photo = (ImageView)findViewById(R.id.photo);
        playerInfo = (RelativeLayout)findViewById(R.id.playerInfo);

    }


}
