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

    public class NetworksView : Gtk.ScrolledWindow{

        public int StatusCode;
        public string Error;
        public string Output;

        public Gtk.ListBox network_list;
        public Gtk.Viewport viewport;
        public Gtk.ListBoxRow NetworkRow;

        public NetworksView () {

            this.expand = true;

            var content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

            viewport = new Gtk.Viewport(null, null);
            viewport.set_halign(Gtk.Align.CENTER);
            viewport.width_request = 450;

            var view_header = new Gtk.Label("Networks List");
            view_header.get_style_context ().add_class ("h1-text");
            view_header.halign = Gtk.Align.START;
            view_header.margin_start = 35;
            view_header.margin_top = 35;
            view_header.margin_bottom = 35;

            update_networks_view();

            content.add(view_header);
            content.add(viewport);
            
            this.add(content);
        }

        public int update_networks_view(){

            var networks_array = new NetworkUtil().networks_from_json_object(new NetworkUtil().get_list_of_networks());
            
            if (networks_array[0, 0] != null) {

                network_list = new Gtk.ListBox();
                network_list.get_style_context ().add_class ("network-list");
                network_list.selection_mode = Gtk.SelectionMode.NONE;
                network_list.row_activated.connect((row) => { ((NetworkRow)row).toggle_revealer(); });

                var networks_array_lenght = int.parse(networks_array[0, 0]);
                print("[DEBUG] Recived Networks JSON" + "\n");
                var i = 0;
                for(i = 0; i < networks_array_lenght; i++){
                    network_list.add(new App.Widgets.NetworkRow(networks_array[i + 1, 0], networks_array[i + 1, 1], networks_array[i + 1, 2], networks_array[i + 1, 3], networks_array[i + 1, 4]));
                }
                this.viewport.add(network_list);

            } else {
                print("Empty network list - it is NULL");
            }

            return(0);
        }
    }
}