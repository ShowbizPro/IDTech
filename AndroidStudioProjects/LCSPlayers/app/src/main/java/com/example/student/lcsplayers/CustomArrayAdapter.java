package com.example.student.lcsplayers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;



/**
 * Created by Student on 8/4/14.
 */
public class CustomArrayAdapter extends ArrayAdapter {
    private final Context context;
    private final ArrayList<String> arrayList;
    public CustomArrayAdapter(Context context, ArrayList<String> objects) {
        super(context, R.layout.row_layout, objects);
        this.context = context;
        this.arrayList = objects;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.row_layout, parent, false);
        String textName = arrayList.get(position);
        if(textName.contains("-0")){
            textName = textName.replace("-0", "");
        }
        if(textName.contains("-")){
            textName = textName.replace("-", " ");
        }

        TextView text = (TextView)rowView.findViewById(R.id.rowTextView);
        text.setText(textName);
        text.setTextColor(context.getResources().getColor(android.R.color.white));
        text.bringToFront();
        return rowView;
    }

    @Override
    public int getCount() {
        return super.getCount();
    }
}
