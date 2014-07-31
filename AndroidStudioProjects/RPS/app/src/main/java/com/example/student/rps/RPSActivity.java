package com.example.student.rps;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.TextView;
import org.apache.http.Header;

import java.util.Random;


public class RPSActivity extends Activity {

    public enum Choice {
        ROCK, PAPER, SCISSORS, LIZARD, SPOCK
    }

    ImageView playerChoice;
    ImageView compChoice;
    ImageButton rock;
    ImageButton paper;
    ImageButton scissors;
    ImageButton lizard;
    ImageButton spock;
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

    int bgColor;
    static boolean sound = true;

    MediaPlayer mp;

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
        lizard = (ImageButton)findViewById(R.id.lizard);
        spock = (ImageButton)findViewById(R.id.spock);

        winsText = (TextView)findViewById(R.id.wins);
        lossText = (TextView)findViewById(R.id.losses);
        tieText = (TextView)findViewById(R.id.ties);

        root = (RelativeLayout)findViewById(R.id.RPSLayout);

        rock.setBackground(getResources().getDrawable(R.drawable.rock));
        paper.setBackground(getResources().getDrawable(R.drawable.paper));
        scissors.setBackground(getResources().getDrawable(R.drawable.scissors));
        lizard.setBackground(getResources().getDrawable(R.drawable.lizard));
        spock.setBackground(getResources().getDrawable(R.drawable.spock));
        rock.setTag("rock");
        paper.setTag("paper");
        scissors.setTag("scissor");
        lizard.setTag("lizard");
        spock.setTag("spock");

        mp= MediaPlayer.create(this, R.raw.rps);

        alert();

        Intent intent2 = getIntent();
        if(intent2.getExtras() != null) {
            root.setBackgroundResource(intent2.getExtras().getInt("bgColor"));
            bgColor = intent2.getExtras().getInt("bgColor");
        }
        else{
            root.setBackgroundColor(-1);
            bgColor = android.R.color.white;
        }

        click(rock);
        click(paper);
        click(scissors);
        click(lizard);
        click(spock);




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

    public void click(final ImageButton iB){
        iB.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(sound) {
                    mp = MediaPlayer.create(RPSActivity.this, R.raw.rps);
                    if (!mp.isPlaying()) {
                        mp.start();
                    }
                    else{
                        mp.seekTo(0);
                    }
                }

                int x = rand.nextInt(5);
                if(iB.getTag() ==("rock")) {
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.rock));
                    playersChoice = Choice.ROCK;
                }
                else if(iB.getTag() ==("paper")){
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.paper));
                    playersChoice = Choice.PAPER;
                }
                else if(iB.getTag() == ("scissor")){
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.scissors));
                    playersChoice = Choice.SCISSORS;
                }
                else if(iB.getTag() == ("lizard")){
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.lizard));
                    playersChoice = Choice.LIZARD;
                }
                else{
                    playerChoice.setBackground(getResources().getDrawable(R.drawable.spock));
                    playersChoice = Choice.SPOCK;
                }
                makeCompChoice(x);

                if(compsChoice == Choice.ROCK){
                    compChoice.setBackground(getResources().getDrawable(R.drawable.rock));
                }
                else if(compsChoice == Choice.PAPER){
                    compChoice.setBackground(getResources().getDrawable(R.drawable.paper));
                }
                else if(compsChoice == Choice.SCISSORS){
                    compChoice.setBackground(getResources().getDrawable(R.drawable.scissors));
                }
                else if(compsChoice == Choice.LIZARD){
                    compChoice.setBackground(getResources().getDrawable(R.drawable.lizard));
                }
                else{
                    compChoice.setBackground(getResources().getDrawable(R.drawable.spock));
                }

                compareChoices();

            }
        });
    }

    public void makeCompChoice(int x){
            if (x == 0) {
                compsChoice = Choice.ROCK;
            }
            else if (x == 1) {
                compsChoice = Choice.PAPER;
            }
            else if(x==2){
                compsChoice = Choice.SCISSORS;
            }
            else if(x==3){
                compsChoice = Choice.LIZARD;
            }
            else{
                compsChoice = Choice.SPOCK;
            }
    }

    public void compareChoices(){
        if(compsChoice==Choice.ROCK){
            if(playersChoice==Choice.ROCK){
                result.setText("Its a tie!");
                ties ++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("You Covered!");
                wins ++;
            }
            else if(playersChoice == Choice.SCISSORS){
                result.setText("You got Crushed!");
                losses ++;
            }
            else if(playersChoice == Choice.LIZARD){
                result.setText("You got Crushed!");
                losses ++;
            }
            else {
                result.setText("You Vaporized!");
                wins ++;
            }
        }
        else if(compsChoice==Choice.PAPER){
            if(playersChoice==Choice.ROCK){
                result.setText("You got Covered!");
                losses ++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("Its a tie!");
                ties ++;
            }
            else if(playersChoice == Choice.SCISSORS){
                result.setText("You Cut!");
                wins++;
            }
            else if(playersChoice == Choice.LIZARD){
                result.setText("You Ate!");
                wins ++;
            }
            else {
                result.setText("You got Disproved!");
                losses ++;
            }
        }
        else if (compsChoice == Choice.SCISSORS){
            if(playersChoice==Choice.ROCK){
                result.setText("You Crushed!");
                wins++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("You got Cut!");
                losses++;
            }
            else if(playersChoice == Choice.SCISSORS){
                result.setText("Its a tie!");
                ties ++;
            }
            else if(playersChoice == Choice.LIZARD){
                result.setText("You got decapitated!");
                losses ++;
            }
            else {
                result.setText("You Smashed!");
                wins ++;
            }
        }
        else if (compsChoice == Choice.LIZARD){
            if(playersChoice==Choice.ROCK){
                result.setText("You Crushed!");
                wins++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("You got Eaten!");
                losses++;
            }
            else if(playersChoice == Choice.SCISSORS){
                result.setText("You Decapitated!");
                wins ++;
            }
            else if(playersChoice == Choice.LIZARD){
                result.setText("Its a Tie!");
                ties ++;
            }
            else {
                result.setText("You got Poisoned!");
                losses ++;
            }
        }
        else{
            if(playersChoice==Choice.ROCK){
                result.setText("You got Vaporized!");
                losses++;
            }
            else if(playersChoice==Choice.PAPER){
                result.setText("You Disproved!");
                wins++;
            }
            else if(playersChoice == Choice.SCISSORS){
                result.setText("You got Smashed!");
                losses ++;
            }
            else if(playersChoice == Choice.LIZARD){
                result.setText("You Poisoned!");
                wins ++;
            }
            else {
                result.setText("Its a Tie!");
                ties ++;
            }
        }
        winsText.setText(wins+"");
        lossText.setText(losses+"");
        tieText.setText(ties+"");
        if(losses == 20){
            rock.setEnabled(false);
            paper.setEnabled(false);
            scissors.setEnabled(false);
            lizard.setEnabled(false);
            spock.setEnabled(false);
            lostDialog.show();
        }
        if(wins == 20){
            rock.setEnabled(false);
            paper.setEnabled(false);
            scissors.setEnabled(false);
            lizard.setEnabled(false);
            spock.setEnabled(false);
            wonDialog.show();

        }

    }

    public void settingsClicked(View view){
        Intent intent = new Intent(this, settingsActivity.class);
        intent.putExtra("bgColor", bgColor);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }

    public void reset(){
        wins = 0;
        losses = 0;
        ties = 0;
        winsText.setText(wins+"");
        lossText.setText(losses+"");
        tieText.setText(ties+"");
        playerChoice.setBackground(null);
        compChoice.setBackground(null);
    }

    public void alert(){
        AlertDialog.Builder builder = new AlertDialog.Builder(RPSActivity.this);

        lostDialog = builder.setTitle("Gosh").setMessage("You lost 20 times already?!").setNeutralButton("Try Again", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                reset();
                rock.setEnabled(true);
                paper.setEnabled(true);
                scissors.setEnabled(true);
                lizard.setEnabled(true);
                spock.setEnabled(true);
                dialogInterface.dismiss();
            }
        }).create();

        builder = new AlertDialog.Builder(RPSActivity.this);

        wonDialog = builder.setTitle("Congratulations").setMessage("You won 20 times!").setNeutralButton("Play Again", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                reset();
                rock.setEnabled(true);
                paper.setEnabled(true);
                scissors.setEnabled(true);
                lizard.setEnabled(true);
                spock.setEnabled(true);
                dialogInterface.dismiss();
            }
        }).create();
    }

    public void goHome(View view){
        Intent intent = new Intent(this, titlePage.class);
        intent.putExtra("bgColor", bgColor);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }

}

