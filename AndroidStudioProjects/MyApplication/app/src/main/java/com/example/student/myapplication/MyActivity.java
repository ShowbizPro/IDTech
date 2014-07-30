package com.example.student.myapplication;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.provider.DocumentsContract;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Random;
import java.util.logging.LogRecord;


public class MyActivity extends Activity {

    TextView viewOfText;
    Button firstButton;
    boolean clicked = false;
    boolean bgclicked = false;
    int counter = 0;
    RelativeLayout rootView;
    Button bgButton;
    Handler handler = new Handler();
    Random rand = new Random();
    ImageButton imgButton;
    int i = 1;

    ArrayList images = new ArrayList();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my);


        Intent intent = getIntent();





        viewOfText = (TextView)findViewById(R.id.textView);
        rootView = (RelativeLayout)findViewById(R.id.rootView);
        viewOfText.setText("Changing the Text");
        images.add(getResources().getDrawable(R.drawable.aatrox));
        images.add(getResources().getDrawable(R.drawable.ahri));
        images.add(getResources().getDrawable(R.drawable.akali));
        images.add(getResources().getDrawable(R.drawable.alistar));
        images.add(getResources().getDrawable(R.drawable.amumu));
        images.add(getResources().getDrawable(R.drawable.anivia));
        images.add(getResources().getDrawable(R.drawable.annie));

        firstButton = (Button)findViewById(R.id.button);
        bgButton = (Button)findViewById(R.id.button2);
        imgButton = (ImageButton)findViewById(R.id.imageButton);

        imgButton.setBackground((Drawable)images.get(0));



        firstButton.setText(intent.getStringExtra("firstString"));


        firstButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (clicked == false) {
                    firstButton.setText("Click me more");
                    viewOfText.setAllCaps(true);
                    viewOfText.setText("you clicked it! " + counter);
                    clicked = true;
                    counter ++;
                    viewOfText.setTextColor(-1);
                    firstButton.setTextColor(-1);
                    rootView.setBackgroundColor(-16777216);

                }
                else {
                    viewOfText.setAllCaps(false);
                    viewOfText.setText("Now stop(if you want) " + counter);
                    clicked = false;
                    counter ++;
                    viewOfText.setTextColor(-16777216);
                    firstButton.setTextColor(-16777216);
                    rootView.setBackgroundColor(-1);
                }

            }

        });

        bgButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        rootView.setBackgroundColor(-rand.nextInt(16777216));
                        handler.postDelayed(this, 1);
                    }
                } , 1);
            }
        });


        imgButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {

                imgButton.setBackground((Drawable) images.get(i));
                i++;
                if(i>=images.size()){
                    i = 0;
                }
            }
        });



    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.my, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
