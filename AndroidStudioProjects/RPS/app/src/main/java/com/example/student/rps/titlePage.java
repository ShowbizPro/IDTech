package com.example.student.rps;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import com.example.student.rps.howTo;

/**
 * Created by Student on 7/30/14.
 */
public class titlePage extends Activity{
    ImageView pic;
    RelativeLayout bg;
    int bgColor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.titlelayout);
        pic = (ImageView)findViewById(R.id.imageView);
        pic.setBackground(getResources().getDrawable(R.drawable.rps));
        bg = (RelativeLayout)findViewById(R.id.titleBG);

        Intent intent = getIntent();
        if(intent.getExtras() != null){
                bg.setBackgroundResource(intent.getExtras().getInt("bgColor"));
                bgColor = intent.getExtras().getInt("bgColor");
        }
        else{
            if(howTo.bgColor == 0) {
                bg.setBackgroundColor(-1);
                bgColor = android.R.color.white;
            }
            else{
                bg.setBackgroundResource(howTo.bgColor);
                bgColor = howTo.bgColor;
            }
        }
    }


//    @Override
//    public boolean onCreateOptionsMenu(Menu menu) {
//        // Inflate the menu; this adds items to the action bar if it is present.
//        getMenuInflater().inflate(R.menu.r, menu);
//        return true;
//    }
//
//    @Override
//    public boolean onOptionsItemSelected(MenuItem item) {
//        // Handle action bar item clicks here. The action bar will
//        // automatically handle clicks on the Home/Up button, so long
//        // as you specify a parent activity in AndroidManifest.xml.
//        int id = item.getItemId();
//        if (id == R.id.action_settings) {
//            Intent intent = new Intent(this, settingsActivity.class);
//            intent.putExtra("bgColor", bgColor);
//            startActivity(intent);
//            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
//            return true;
//        }
//        if (id == R.id.home_page) {
//            Intent intent = new Intent(this, titlePage.class);
//            intent.putExtra("bgColor", bgColor);
//            startActivity(intent);
//            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
//            return true;
//        }
//        if (id == R.id.rps) {
//            Intent intent = new Intent(this, RPSActivity.class);
//            intent.putExtra("bgColor", bgColor);
//            startActivity(intent);
//            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
//            return true;
//        }
//        if (id == R.id.rules) {
//            Intent intent = new Intent(this, howTo.class);
//            intent.putExtra("bgColor", bgColor);
//            startActivity(intent);
//            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
//            return true;
//        }
//        return super.onOptionsItemSelected(item);
//    }

    public void startGame(View view) {
        Intent intent = new Intent(this, RPSActivity.class);
        intent.putExtra("bgColor", bgColor);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }
    public void goToRules(View view){
        Intent intent = new Intent(this, howTo.class);
        intent.putExtra("bgColor", bgColor);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }
}
