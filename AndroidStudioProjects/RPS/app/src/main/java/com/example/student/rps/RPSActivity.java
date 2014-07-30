package com.example.student.rps;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import org.apache.http.Header;

import java.util.Random;


public class RPSActivity extends Activity {

    public enum Choice {
        ROCK, PAPER, SCISSORS
    }

    ImageView playerChoice;
    ImageView compChoice;
    ImageButton rock;
    ImageButton paper;
    ImageButton scissors;
    TextView winsText;
    TextView lossText;
    TextView tieText;
    Random rand = new Random();
    RelativeLayout root;

    TextView result;
    Choice playersChoice;
    Choice compsChoice;
    int wins;
    int losses;
    int ties;
    AlertDialog lostDialog;
    AlertDialog wonDialog;
    AlertDialog tiedDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rps);
        playerChoice = (ImageView)findViewById(R.id.playerChoice);
        compChoice = (ImageView)findViewById(R.id.compChoice);
        rock = (ImageButton)findViewById(R.id.rock);
        paper = (ImageButton)findViewById(R.id.paper);
        scissors = (ImageButton)findViewById(R.id.scissor);
        result = (TextView)findViewById(R.id.result);

        winsText = (TextView)findViewById(R.id.wins);
        lossText = (TextView)findViewById(R.id.losses);
        tieText = (TextView)findViewById(R.id.ties);

        root = (RelativeLayout)findViewById(R.id.RPSLayout);

        rock.setBackground(getResources().getDrawable(R.drawable.rock));
        paper.setBackground(getResources().getDrawable(R.drawable.paper));
        scissors.setBackground(getResources().getDrawable(R.drawable.scissors));
        rock.setTag("rock");
        paper.setTag("paper");
        scissors.setTag("scissor");

        Intent colorIntent = getIntent();

        root.setBackgroundColor(colorIntent.getExtras().getInt("bgColor"));




        AlertDialog.Builder builder = new AlertDialog.Builder(RPSActivity.this);

        lostDialog = builder.setTitle("Gosh").setMessage("You lost 10 times already?!").setNeutralButton("Try Again", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                wins = 0;
                losses = 0;
                ties = 0;
                dialogInterface.dismiss();
                winsText.setText(wins+"");
                lossText.setText(losses+"");
                tieText.setText(ties+"");
            }
        }).setNegativeButton("Change Difficulty", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Intent intent = new Intent(RPSActivity.this, settingsActivity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
            }
        }).create();

        wonDialog = builder.setTitle("Congratulations").setMessage("You won 10 times!").setNeutralButton("Play Again", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                wins = 0;
                losses = 0;
                ties = 0;
                dialogInterface.dismiss();
                winsText.setText(wins+"");
                lossText.setText(losses+"");
                tieText.setText(ties+"");

            }
        }).create();





        click(rock);
        click(paper);
        click(scissors);




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
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void click(final ImageButton iB){
        iB.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int x = rand.nextInt(3);
                if(iB.getTag() ==("rock")) {
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.rock));
                    playersChoice = Choice.ROCK;
                }
                else if(iB.getTag() ==("paper")){
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.paper));
                    playersChoice = Choice.PAPER;
                }
                else{
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.scissors));
                    playersChoice = Choice.SCISSORS;
                }
                makeCompChoice(x);

                if(compsChoice == Choice.ROCK){
                    compChoice.setBackground(getResources().getDrawable(R.drawable.rock));
                }
                else if(compsChoice == Choice.PAPER){
                    compChoice.setBackground(getResources().getDrawable(R.drawable.paper));
                }
                else{
                    compChoice.setBackground(getResources().getDrawable(R.drawable.scissors));
                }

                compareChoices();

            }
        });
    }

    public void makeCompChoice(int x){
        Intent intent = getIntent();
        if(!intent.getExtras().getBoolean("hardMode") && !intent.getExtras().getBoolean("easyMode")) {
            if (x == 0) {
                compsChoice = Choice.ROCK;
            } else if (x == 1) {
                compsChoice = Choice.PAPER;
            } else {
                compsChoice = Choice.SCISSORS;
            }
        }
        else if(intent.getExtras().getBoolean("hardMode") && !intent.getExtras().getBoolean("easyMode")){
            if(playersChoice == Choice.ROCK){
                compsChoice = Choice.PAPER;
            }
            else if(playersChoice == Choice.PAPER){
                compsChoice = Choice.SCISSORS;
            }
            else{
                compsChoice = Choice.ROCK;
            }
        }
        else{
            if(playersChoice == Choice.ROCK){
                compsChoice = Choice.SCISSORS;
            }
            else if(playersChoice == Choice.PAPER){
                compsChoice = Choice.ROCK;
            }
            else{
                compsChoice = Choice.PAPER;
            }
        }

    }

    public void compareChoices(){
        if(compsChoice==Choice.ROCK){
            if(playersChoice==Choice.ROCK){
                result.setText("Its a tie!");
                ties ++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("You Win!");
                wins ++;
            }
            else{
                result.setText("You Lose!");
                losses ++;
            }
        }
        else if(compsChoice==Choice.PAPER){
            if(playersChoice==Choice.ROCK){
                result.setText("You Lose!");
                losses ++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("Its a tie!");
                ties ++;
            }
            else{
                result.setText("You Win!");
                wins++;
            }
        }
        else{
            if(playersChoice==Choice.ROCK){
                result.setText("You Win!");
                wins++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("You Lose!");
                losses++;
            }
            else{
                result.setText("Its a tie!");
                ties ++;
            }
        }
        winsText.setText(wins+"");
        lossText.setText(losses+"");
        tieText.setText(ties+"");
        if(losses == 10){
            lostDialog.show();
        }
        if(wins == 10){
            wonDialog.show();

        }

    }

    public void settingsClicked(View view){
        Intent intent = new Intent(this, settingsActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }

}
