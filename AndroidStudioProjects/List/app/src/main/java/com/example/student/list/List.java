package com.example.student.list;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class List extends ListActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);
        Map<String, String> map1 = new HashMap<String, String>();
        Map<String, String> map2 = new HashMap<String, String>();
        Map<String, String> map3 = new HashMap<String, String>();

        map1.put("First Name", "Bob");
        map1.put("Last Name", "The Builder");

        map2.put("First Name", "Bill");
        map2.put("Last Name", "WobbleStein");

        map3.put("First Name", "Chewie");
        map3.put("Last Name", "Nuggets");

        ArrayList<Map<String, String>> arrayList = new ArrayList<Map<String, String>>();
        arrayList.add(map1);
        arrayList.add(map2);
        arrayList.add(map3);
        CustomArrayAdapter adapter = new CustomArrayAdapter(this, arrayList);

        setListAdapter(adapter);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.list, menu);
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
    private class CustomArrayAdapter extends ArrayAdapter<Map<String, String>> {
        private final Context context;
        private final ArrayList<Map<String, String>> arrayList;

        public CustomArrayAdapter(Context context, ArrayList<Map<String, String>> objects) {
            super(context, R.layout.row_layout, objects);
            this.context = context;
            this.arrayList = objects;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            View rowView = inflater.inflate(R.layout.row_layout, parent, false);

            TextView textView1 = (TextView) rowView.findViewById(R.id.textView);
            TextView textView2 = (TextView) rowView.findViewById(R.id.textView2);

            Map<String, String> object = arrayList.get(position);

            textView1.setText(object.get("First Name"));
            textView2.setText(object.get("Last Name"));

            return rowView;
        }
    }
}

