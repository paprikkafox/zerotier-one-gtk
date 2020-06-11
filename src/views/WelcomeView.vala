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

    public class WelcomeView : Gtk.Box {

        public WelcomeView (Gtk.Stack view_stack) {

            this.set_orientation(Gtk.Orientation.VERTICAL);

            var welcome_header = new Gtk.Label("Stay connected");
            var welcome_image = new Gtk.Image.from_icon_name("network-server", Gtk.IconSize.DIALOG);
            var welcome_description = new Gtk.Label("To add some networks click 'Add' button on the top bar");
            var get_auth_button = new Gtk.Button();


            welcome_header.get_style_context ().add_class ("h1-text");
            welcome_header.vexpand = true;

            welcome_image.pixel_size = 128;
            welcome_image.vexpand = true;

            welcome_description.vexpand = true;
            welcome_description.set_justify(Gtk.Justification.CENTER);
            get_auth_button.label = "Create";
            get_auth_button.halign = Gtk.Align.CENTER;
            get_auth_button.margin_bottom = 35;

            get_auth_button.clicked.connect (() => {
                new NetworkUtil().createAuthToken();
                view_stack.set_visible_child_name("networks-view");

            });

            this.add(welcome_header);
            this.add(welcome_image);
            this.add(welcome_description);

            if (FileUtils.test(GLib.Environment.get_home_dir() + "/.zeroTierOneAuthToken", FileTest.EXISTS) == true){
                print("[DEBUG] All is OK, listing some networks...");
                
                var network_util = new NetworkUtil();
                var networks  = network_util.networks_from_json_object(network_util.get_list_of_networks());
                print(networks[1,1]);

            } else {
                print("[DEBUG] Auth token not exsists! Showing SETUP...");

                welcome_header.set_text("Creating auth token");
                welcome_description.set_text("Auth token is needed for using app without superuser rights. \n Click 'Create' to continue");
                welcome_image.set_from_icon_name("system-lock-screen", Gtk.IconSize.DIALOG);
                welcome_image.pixel_size = 128;
                
                this.add(get_auth_button);
            }
        }
    }
}