package com.example.student.rps;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.Switch;
import android.widget.TextView;
import com.example.student.rps.RPSActivity;

/**
 * Created by Student on 7/29/14.
 */
public class settingsActivity extends Activity {


    RelativeLayout root;
    int bgColor;
    Button blue;
    Button red;
    Button green;
    Button white;
    Button grey;
    Button purple;
    Button orange;


    ImageView black1;
    ImageView black2;
    ImageView black3;
    ImageView black4;
    ImageView black5;
    ImageView black6;
    ImageView black7;


    RelativeLayout settings;
    Switch soundOnOff;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.settingsactivity);
        settings = (RelativeLayout)findViewById(R.id.settings);
        soundOnOff = (Switch)findViewById(R.id.switch1);
        if (RPSActivity.sound == true){
            soundOnOff.setChecked(true);
        }
        else{
            soundOnOff.setChecked(false);
        }

        soundOnOff.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if(soundOnOff.isChecked()){
                    RPSActivity.sound = true;
                }
                else{
                    RPSActivity.sound = false;
                }
            }
        });


        Intent intent = getIntent();
        if(intent.getExtras() != null){
            settings.setBackgroundResource(intent.getExtras().getInt("bgColor"));
            bgColor = intent.getExtras().getInt("bgColor");
        }
        else{
            settings.setBackgroundColor(-1);
        }

        black1 = (ImageView)findViewById(R.id.black1);
        black1.setBackgroundColor(getResources().getColor(android.R.color.black));
        black2 = (ImageView)findViewById(R.id.black2);
        black2.setBackgroundColor(getResources().getColor(android.R.color.black));
        black3 = (ImageView)findViewById(R.id.black3);
        black3.setBackgroundColor(getResources().getColor(android.R.color.black));
        black4 = (ImageView)findViewById(R.id.black4);
        black4.setBackgroundColor(getResources().getColor(android.R.color.black));
        black5 = (ImageView)findViewById(R.id.black5);
        black5.setBackgroundColor(getResources().getColor(android.R.color.black));
        black6 = (ImageView)findViewById(R.id.black6);
        black6.setBackgroundColor(getResources().getColor(android.R.color.black));
        black7 = (ImageView)findViewById(R.id.black7);
        black7.setBackgroundColor(getResources().getColor(android.R.color.black));


        root = (RelativeLayout)findViewById(R.id.settings);
        blue = (Button)findViewById(R.id.blue);
        blue.bringToFront();
        blue.setTag(android.R.color.holo_blue_bright);
        red = (Button)findViewById(R.id.red);
        red.bringToFront();
        red.setTag(android.R.color.holo_red_dark);
        green = (Button)findViewById(R.id.green);
        green.bringToFront();
        green.setTag(android.R.color.holo_green_light);
        white = (Button)findViewById(R.id.white);
        white.bringToFront();
        white.setTag(android.R.color.white);
        grey = (Button)findViewById(R.id.grey);
        grey.bringToFront();
        grey.setTag(android.R.color.darker_gray);
        purple = (Button)findViewById(R.id.purple);
        purple.bringToFront();
        purple.setTag(android.R.color.holo_purple);
        orange = (Button)findViewById(R.id.orange);
        orange.bringToFront();
        orange.setTag(android.R.color.holo_orange_light);

        colorButton(blue);
        colorButton(red);
        colorButton(green);
        colorButton(white);
        colorButton(grey);
        colorButton(purple);
        colorButton(orange);



    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.r, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
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
        return super.onOptionsItemSelected(item);
    }

    public void gottaGoBack(View view){
            Intent intent = new Intent(this, RPSActivity.class);
            intent.putExtra("bgColor", bgColor);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }
    public void colorButton(Button b){
        b.setBackgroundColor(getResources().getColor((Integer) b.getTag()));
    }
    public void changeBg(View view){
            root.setBackgroundResource((Integer) view.getTag());
            bgColor = (Integer)view.getTag();
    }





}
