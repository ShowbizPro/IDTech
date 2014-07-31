package com.example.student.rps;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.support.v4.app.NavUtils;

/**
 * Created by Student on 7/30/14.
 */
public class howTo extends Activity {
    ImageView rock1;
    ImageView rock2;
    ImageView rock3;
    ImageView rock4;
    ImageView paper1;
    ImageView paper2;
    ImageView paper3;
    ImageView paper4;
    ImageView scis1;
    ImageView scis2;
    ImageView scis3;
    ImageView scis4;
    ImageView lizard1;
    ImageView lizard2;
    ImageView lizard3;
    ImageView lizard4;
    ImageView spock1;
    ImageView spock2;
    ImageView spock3;
    ImageView spock4;
    RelativeLayout howToo;
    static int bgColor;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.how_to);
        getActionBar().setDisplayHomeAsUpEnabled(true);
        howToo=(RelativeLayout)findViewById(R.id.howTo);

        Intent intent = getIntent();

        if(intent.getExtras() != null){
            howToo.setBackgroundResource(intent.getExtras().getInt("bgColor"));
            bgColor = intent.getExtras().getInt("bgColor");
        }
        else{
            howToo.setBackgroundColor(-1);
            bgColor = android.R.color.white;
        }




        rock1 = (ImageView)findViewById(R.id.rock1);
        rock2 = (ImageView)findViewById(R.id.rock2);
        rock3 = (ImageView)findViewById(R.id.rock3);
        rock4 = (ImageView)findViewById(R.id.rock4);

        paper1 = (ImageView)findViewById(R.id.paper1);
        paper2 = (ImageView)findViewById(R.id.paper2);
        paper3 = (ImageView)findViewById(R.id.paper3);
        paper4 = (ImageView)findViewById(R.id.paper4);

        scis1 = (ImageView)findViewById(R.id.scis1);
        scis2 = (ImageView)findViewById(R.id.scis2);
        scis3 = (ImageView)findViewById(R.id.scis3);
        scis4 = (ImageView)findViewById(R.id.scis4);

        lizard1 = (ImageView)findViewById(R.id.lizard1);
        lizard2 = (ImageView)findViewById(R.id.lizard2);
        lizard3 = (ImageView)findViewById(R.id.lizard3);
        lizard4 = (ImageView)findViewById(R.id.lizard4);

        spock1 = (ImageView)findViewById(R.id.spock1);
        spock2 = (ImageView)findViewById(R.id.spock2);
        spock3 = (ImageView)findViewById(R.id.spock3);
        spock4 = (ImageView)findViewById(R.id.spock4);

        rock1.setBackground(getResources().getDrawable(R.drawable.rock));
        rock2.setBackground(getResources().getDrawable(R.drawable.rock));
        rock3.setBackground(getResources().getDrawable(R.drawable.rock));
        rock4.setBackground(getResources().getDrawable(R.drawable.rock));

        paper1.setBackground(getResources().getDrawable(R.drawable.paper));
        paper2.setBackground(getResources().getDrawable(R.drawable.paper));
        paper3.setBackground(getResources().getDrawable(R.drawable.paper));
        paper4.setBackground(getResources().getDrawable(R.drawable.paper));

        scis1.setBackground(getResources().getDrawable(R.drawable.scissors));
        scis2.setBackground(getResources().getDrawable(R.drawable.scissors));
        scis3.setBackground(getResources().getDrawable(R.drawable.scissors));
        scis4.setBackground(getResources().getDrawable(R.drawable.scissors));

        lizard1.setBackground(getResources().getDrawable(R.drawable.lizard));
        lizard2.setBackground(getResources().getDrawable(R.drawable.lizard));
        lizard3.setBackground(getResources().getDrawable(R.drawable.lizard));
        lizard4.setBackground(getResources().getDrawable(R.drawable.lizard));

        spock1.setBackground(getResources().getDrawable(R.drawable.spock));
        spock2.setBackground(getResources().getDrawable(R.drawable.spock));
        spock3.setBackground(getResources().getDrawable(R.drawable.spock));
        spock4.setBackground(getResources().getDrawable(R.drawable.spock));


    }
    public void goHome(View view){
        Intent intent = new Intent(this, titlePage.class);
        intent.putExtra("bgColor", bgColor);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }    @Override
         public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.r, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            Intent intent = new Intent(this, settingsActivity.class);
            intent.putExtra("bgColor", bgColor);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            return true;
        }
        if (id == R.id.home_page) {
            Intent intent = new Intent(this, titlePage.class);
            intent.putExtra("bgColor", bgColor);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            return true;
        }
        if (id == R.id.rps) {
            Intent intent = new Intent(this, RPSActivity.class);
            intent.putExtra("bgColor", bgColor);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            return true;
        }
        if (id == R.id.rules) {
            Intent intent = new Intent(this, howTo.class);
            intent.putExtra("bgColor", bgColor);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            return true;
        }
        switch (item.getItemId()) {

            case android.R.id.home:
                NavUtils.navigateUpFromSameTask(this);
                overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
                return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
