package com.example.student.rps;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

/**
 * Created by Student on 7/30/14.
 */
public class titlePage extends Activity{
       ImageView pic;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.titlelayout);
        pic = (ImageView)findViewById(R.id.imageView);
        pic.setBackground(getResources().getDrawable(R.drawable.rps));
    }



    public void startGame(View view) {
        Intent intent = new Intent(this, settingsActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }
}
