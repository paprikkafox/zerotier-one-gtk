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

        public Gtk.Label welcome_header;
        public Gtk.Image welcome_image;
        public Gtk.Label welcome_description;
        public Gtk.Button get_auth_button;

        public string[,] networks_array;
        public int networks_array_lenght;

        public WelcomeView (Gtk.Stack view_stack) {

            this.set_orientation(Gtk.Orientation.VERTICAL);

            welcome_header = new Gtk.Label("Stay connected");
            welcome_header.vexpand = true;
            welcome_header.get_style_context ().add_class ("h1-text");

            welcome_image = new Gtk.Image.from_icon_name("network-server", Gtk.IconSize.DIALOG);
            welcome_image.vexpand = true;
            welcome_image.pixel_size = 128;

            welcome_description = new Gtk.Label("To add some networks click 'Add' button on the top bar");
            welcome_description.vexpand = true;
            welcome_description.set_justify(Gtk.Justification.CENTER);

            this.add(welcome_header);
            this.add(welcome_image);
            this.add(welcome_description);

            if (new App.Utils.NetworkUtil().checkAuthToken() != 0){
                setup_screen();
            } else {
                networks_array = new NetworkUtil().networks_from_json_object(new NetworkUtil().get_list_of_networks());

                if (networks_array[0, 0] != null){
                    networks_array_lenght = int.parse(networks_array[0, 0]);
                } else {
                    networks_array_lenght = 0;
                    print("[DEBUG] Networks is NULL - FROM WINDOW.VALA \n");
                }

                view_stack.add_named(new NetworksView (networks_array, networks_array_lenght), "networks-view");

                if (networks_array_lenght > 0){
                    view_stack.set_visible_child_name("networks-view"); 
                } else {
                    print ("[DEBUG] NO NETWORKS\n");
                    view_stack.get_child_by_name("networks-view").hide(); 

                }


            }

            this.show();

        }

        public void setup_screen(){

            get_auth_button = new Gtk.Button();
            get_auth_button.halign = Gtk.Align.CENTER;
            get_auth_button.margin_bottom = 35;
            get_auth_button.label = "Create";

            welcome_header.set_text("Creating auth token");
            welcome_description.set_text("Auth token is needed for using app without superuser rights. \n Click 'Create' to continue");
            welcome_image.set_from_icon_name("system-lock-screen", Gtk.IconSize.DIALOG);
            welcome_image.pixel_size = 128;

            this.add(get_auth_button);

            get_auth_button.clicked.connect (() => {
                new NetworkUtil().createAuthToken();
                if (new App.Utils.NetworkUtil().checkAuthToken() == 0){

                    welcome_header.set_text("Stay connected");
                    welcome_description.set_text("To add some networks click 'Add' button on the top bar");
                    welcome_image.set_from_icon_name("network-server", Gtk.IconSize.DIALOG);
                    welcome_image.pixel_size = 128;
                    get_auth_button.destroy();

                }
            });
        }

    }
}