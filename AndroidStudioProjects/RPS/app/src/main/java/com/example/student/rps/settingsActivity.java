package com.example.student.rps;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.TextView;

/**
 * Created by Student on 7/29/14.
 */
public class settingsActivity extends Activity {

    boolean hard;
    boolean easy;
    Button goBack;
    Button easyButton;
    Button medButton;
    Button hardButton;
    boolean difficulty;
    TextView difficult;
    RelativeLayout root;
    int bgColor;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.settingsactivity);
        goBack = (Button)findViewById(R.id.goBack);
        easyButton = (Button)findViewById(R.id.easyButton);
        medButton = (Button)findViewById(R.id.medButton);
        hardButton = (Button)findViewById(R.id.hardButton);
        difficult = (TextView)findViewById(R.id.difficult);
        root = (RelativeLayout)findViewById(R.id.settings);

        easyButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                easy = true;
                difficulty = true;
                hard = false;
                difficult.setText("Easy difficulty is active");
                root.setBackgroundColor(-16711681);
                bgColor = -16711681;
            }
        });

        medButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                hard = false;
                difficulty = true;
                easy = false;
                difficult.setText("Medium difficulty is active");
                root.setBackgroundColor(-65281);
                bgColor = -65281;
            }
        });
        hardButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                difficulty = true;
                hard = true;
                easy = false;
                difficult.setText("Hard difficulty is active");
                root.setBackgroundColor(-7829368);
                bgColor = -7829368;
            }
        });

    }

    public void gottaGoBack(View view){
        if(difficulty) {
            Intent intent = new Intent(this, RPSActivity.class);
            intent.putExtra("hardMode", hard);
            intent.putExtra("easyMode", easy);
            intent.putExtra("bgColor", bgColor);
            startActivity(intent);
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
        }
        else{
            difficult.setText("Please Select A Difficulty First");
        }
    }

}
