package com.example.student.myapplication;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

/**
 * Created by Student on 7/29/14.
 */
public class Activity2 extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_linear_layout);
    }
    public void buttonClicked(View view) {
        Intent intent = new Intent(this, MyActivity.class);
        EditText textfield = (EditText)findViewById(R.id.originalTextField);
        intent.putExtra("firstString", textfield.getText().toString());

        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.slide_out_bot);
    }
}
