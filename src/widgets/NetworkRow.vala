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

namespace App.Widgets {

    public class NetworkRow : Gtk.ListBoxRow {   

        public int row_id;

        public string nw_name = "N";
        public string nw_id = "asd213123";
        public string nw_auth_status = "OK";
        public string nw_type = "PRIVATE";
        public string mac_addr = "11:11:11:11:11";
        public string nw_assigned_ips = "111.111.111.111";

        public NetworkRow () {

            height_request = 80;
            expand = true;
            selectable = false;
            
            var container1 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            var container2 = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            var container3 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            var labels_grid = new Gtk.Grid();

            var network_status_icon = new Gtk.Image.from_icon_name("emblem-shared", Gtk.IconSize.DIALOG);

            var nw_name_label = new Gtk.Label(nw_name);
            var nw_id_label = new Gtk.Label(nw_id);

            var nw_auth_status_label = new Gtk.Label(nw_auth_status);
            var nw_type_label = new Gtk.Label(nw_type);
            var mac_addr_label = new Gtk.Label(mac_addr);
            var nw_assigned_ips_label = new Gtk.Label(nw_assigned_ips); 

            var sep = new Gtk.Separator(Gtk.Orientation.VERTICAL);

            nw_name_label.get_style_context ().add_class ("h1-title");
            nw_name_label.set_halign(Gtk.Align.START);
            nw_id_label.set_halign(Gtk.Align.START);

            sep.width_request = 450; 
            sep.height_request = 2;
            sep.set_halign(Gtk.Align.CENTER);

            container1.add(container2);
            container1.add(sep);
            container1.add(labels_grid);

            container2.margin_top = 15;
            container2.margin_bottom = 15;
            container2.margin_start = 15;
            container2.add(network_status_icon);
            container2.add(container3);

            container3.margin_start = 15;
            container3.set_valign(Gtk.Align.CENTER);
            container3.add(nw_name_label);
            container3.add(nw_id_label);

            labels_grid.column_homogeneous = true;
            labels_grid.margin_top = 15;
            labels_grid.margin_bottom = 15;

            labels_grid.attach(new Gtk.Label("Status"), 0, 0, 1, 1);
            labels_grid.attach(new Gtk.Label("Network type"), 0, 1, 1, 1);
            labels_grid.attach(new Gtk.Label("MAC address"), 0, 2, 1, 1);
            labels_grid.attach(new Gtk.Label("Assigned IPs"), 0, 3, 1, 1);

            labels_grid.attach(nw_auth_status_label, 1, 0, 1, 1);
            labels_grid.attach(nw_type_label, 1, 1, 1, 1);
            labels_grid.attach(mac_addr_label, 1, 2, 1, 1);
            labels_grid.attach(nw_assigned_ips_label, 1, 3, 1, 1);

            this.add(container1);
            
        }
    }
}

