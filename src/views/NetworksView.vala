/* Copyright 2020 Dmitry Fox <paprikka.fox@gmail.com>
*
* This program is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see http://www.gnu.org/licenses/.
*/

using App.Widgets;
using App.Utils;
namespace App.Views {

    public class NetworksView : Gtk.Box{

        public int StatusCode;
        public string Error;
        public string Output;

        public Gtk.ListBox network_list;

        public NetworksView () {

            this.orientation = Gtk.Orientation.VERTICAL;

            var scrolled_window = new Gtk.ScrolledWindow(null, null);
            var viewport = new Gtk.Viewport(null, null);

            scrolled_window.expand = true;
            scrolled_window.add(viewport);

            viewport.set_halign(Gtk.Align.CENTER);
            viewport.width_request = 450;

            var view_header = new Gtk.Label("Networks List");
            view_header.get_style_context ().add_class ("h1-text");
            view_header.halign = Gtk.Align.START;
            view_header.margin_start = 35;
            view_header.margin_top = 35;
            view_header.margin_bottom = 35;


            network_list = new Gtk.ListBox();
            
            if (FileUtils.test(GLib.Environment.get_home_dir() + "/.zeroTierOneAuthToken", FileTest.EXISTS) == true){
                print("[DEBUG] All is OK, listing some networks...");

                //newtworks list code


            } else {
                print("[DEBUG] Auth file not exsists! Creating a new one...");

                new NetworkUtil().createAuthToken();
            }

            
            //  var nwks = new NetworkUtil().networks_from_json_object(new NetworkUtil().get_list_of_networks());

            network_list.add(new App.Widgets.NetworkRow());
            network_list.add(new App.Widgets.NetworkRow());
            network_list.add(new App.Widgets.NetworkRow());


            viewport.add(network_list);
            
            this.add(view_header);
            this.add(scrolled_window);
        }
    }
}