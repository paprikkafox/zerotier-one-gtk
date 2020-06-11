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
        public Gtk.ListBoxRow NetworkRow;

        public NetworksView () {

            this.expand = true;

            var content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

            var viewport = new Gtk.Viewport(null, null);
            viewport.set_halign(Gtk.Align.CENTER);
            viewport.width_request = 450;

            var view_header = new Gtk.Label("Networks List");
            view_header.get_style_context ().add_class ("h1-text");
            view_header.halign = Gtk.Align.START;
            view_header.margin_start = 35;
            view_header.margin_top = 35;
            view_header.margin_bottom = 35;

            network_list = new Gtk.ListBox();
            network_list.get_style_context ().add_class ("network-list");
    
            var nwks = new NetworkUtil().networks_from_json_object(new NetworkUtil().get_list_of_networks());
            network_list.selection_mode = Gtk.SelectionMode.NONE;

            var name = nwks[1, 0];
            var id = nwks[1, 1];
            var status = nwks[1, 2];
            var type = nwks[1, 3];
            var ips = nwks[1, 4];

            network_list.add(new App.Widgets.NetworkRow(name, id, status, type, ips));

            name = nwks[2, 0];
            id = nwks[2, 1];
            status = nwks[2, 2];
            type = nwks[2, 3];
            ips = nwks[2, 4];

            network_list.add(new App.Widgets.NetworkRow(name, id, status, type, ips));


            network_list.row_activated.connect((row) => { ((NetworkRow)row).toggle_revealer(); });

            viewport.add(network_list);

            content.add(view_header);
            content.add(viewport);
            
            this.add(content);
        }
    }
}