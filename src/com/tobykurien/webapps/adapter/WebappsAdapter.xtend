package com.tobykurien.webapps.adapter

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.tobykurien.webapps.R
import com.tobykurien.webapps.data.Webapp
import com.tobykurien.webapps.utils.FaviconHandler
import java.io.File
import java.util.List
import org.xtendroid.adapter.AndroidAdapter
import org.xtendroid.adapter.AndroidViewHolder

/**
 * Android adapter to display webapps using the row_webapp layout
 */
@AndroidAdapter class WebappsAdapter {
   List<Webapp> webapps
   var FaviconHandler favicoHandler

   /**
    * ViewHolder class to save references to UI widgets in each row
    */
   @AndroidViewHolder(R.layout.row_webapp) static class ViewHolder {      
   }
   
   override getView(int row, View cv, ViewGroup parent) {
      var vh = ViewHolder.getOrCreate(context, cv, parent)
      var app = getItem(row)
      
      vh.name.text = app.name
      vh.url.text = app.url
      
      if (favicoHandler == null) favicoHandler = new FaviconHandler(context)
      var favico = favicoHandler.getFavIcon(app.id)
      loadFavicon(context, favico, vh.favicon)
      
      return vh.view
   }
   
   /**
    * Load a favicon into an imageview
    */
   def static loadFavicon(Context context, File favico, ImageView view) {
      if (favico.exists) {
         Glide.with(context)
           .load(favico)
           .centerCrop()
           .placeholder(R.drawable.ic_action_site)
           .crossFade()
           .into(view);
      }
   }
}