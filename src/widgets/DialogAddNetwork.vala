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

using App.Configs;
using App.Utils;
using App.Views;

namespace App.Widgets {

    public class DialogAddNetwork : Gtk.MessageDialog {

        private App.Configs.Settings settings;

        public Gtk.Entry network_id;
        
        public DialogAddNetwork (Gtk.ApplicationWindow parent, Gtk.Stack view_stack) {
            Object (
                message_type : Gtk.MessageType.OTHER,
                text : "Connect to network",
                secondary_text : "Enter Network ID below:",
                buttons : Gtk.ButtonsType.OK_CANCEL,
                resizable : false,
                deletable : false,
                modal : true,
                width_request : 400,
                height_request : 200,
                transient_for : parent
            );

            this.settings = App.Configs.Settings.get_instance ();

            var container = get_content_area();

            network_id = new Gtk.Entry();
            network_id.halign = Gtk.Align.CENTER;
            network_id.width_request = 250;
            network_id.placeholder_text = "Network ID";
            network_id.primary_icon_name = "network-connect";

            container.add(network_id);
            container.show_all();

            var response = this.run();
            if (response == Gtk.ResponseType.OK){
                print("[DEBUG] Connect dialog closed by clicking OK button\n");
                if (network_id.get_text() == ""){
                    this.destroy();
                } else {
                    new NetworkUtil().connect_to_network_id(network_id.get_text());
                    //here we need to go and update networks view
                    //  new NetworksView().update_networks_view();
                    view_stack.set_visible_child_name("networks-view");
                }
            }
            else if (response == Gtk.ResponseType.CANCEL){
                print("[DEBUG] Connect dialog closed by clicking CANCEL button\n");
            } 

            this.destroy();
           
        }

        
    }
}