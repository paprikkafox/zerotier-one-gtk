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

        public Gtk.Revealer properties_revealer;

        public Gtk.Label network_name;
        public Gtk.Label network_id;

        public Gtk.Label network_status;
        public Gtk.Label network_type;
        public Gtk.Label network_ips;

        public NetworkRow (string name, string id, string status, string type, string ips) {

            this.get_style_context ().add_class ("network-row");
            this.margin_bottom = 15;

            // Main Container
            var eventbox = new Gtk.EventBox();
            // Row Content Container (Subcontainer)
            var row_content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

            // Status icon stack
            var network_status_stack = new Gtk.Stack();
            network_status_stack.set_size_request(64,64);

            var status_image_ok = new Gtk.Image.from_icon_name("add-symbolic", Gtk.IconSize.DIALOG);
            var status_image_auth = new Gtk.Image.from_icon_name("add-symbolic", Gtk.IconSize.DIALOG);

            network_status_stack.add_named(status_image_ok, "status-ok");
            network_status_stack.add_named(status_image_auth, "status-auth");

            // Network row name labels
            var row_header_labels = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

            row_header_labels.valign = Gtk.Align.CENTER;
            network_name = new Gtk.Label(name);
            network_name.halign = Gtk.Align.START;
            network_name.get_style_context ().add_class ("h1-text");

            network_id = new Gtk.Label(id);
            network_id.halign = Gtk.Align.START;
            network_id.get_style_context ().add_class ("h4-text");

            row_header_labels.add(network_name);
            row_header_labels.add(network_id);

            // Row head container
            var row_header = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            row_header.add(network_status_stack);
            row_header.add(row_header_labels);

            // Network info box
            var info_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
            info_box.margin = 15;

            var cont1 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            var cont2 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

            cont1.expand = true;
            cont1.halign = Gtk.Align.END;
            cont1.margin_end = 15;
            cont1.spacing = 4;

            cont2.expand = true;
            cont2.halign = Gtk.Align.START;
            cont2.margin_start = 15;
            cont2.spacing = 4;

            var nwk_status_title = new Gtk.Label("Network status");
            var nwk_type_title = new Gtk.Label("Type");
            var nwk_ips_title = new Gtk.Label("Network IPs");

            nwk_status_title.halign = Gtk.Align.END;
            nwk_type_title.halign = Gtk.Align.END;
            nwk_ips_title.halign = Gtk.Align.END;

            network_status = new Gtk.Label(status);
            network_type = new Gtk.Label(type);
            network_ips = new Gtk.Label(ips);

            network_status.halign = Gtk.Align.START;
            network_type.halign = Gtk.Align.START;
            network_ips.halign = Gtk.Align.START;

            cont1.add(nwk_status_title);
            cont1.add(nwk_type_title);
            cont1.add(nwk_ips_title);

            cont2.add(network_status);
            cont2.add(network_type);
            cont2.add(network_ips);

            info_box.add(cont1);
            info_box.add(new Gtk.Separator(Gtk.Orientation.VERTICAL));
            info_box.add(cont2);

            // Bottom (buttons) box
            var bottom_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            bottom_box.margin = 15;
            var disconnect_button = new Gtk.Button();
            disconnect_button.label = "Leave";
            disconnect_button.width_request = 100;
            disconnect_button.halign = Gtk.Align.END;

            disconnect_button.clicked.connect (() => {
                new NetworkUtil().disconnect_from_network_id(network_id.get_text());
                this.destroy();
                
            });

            bottom_box.pack_end(disconnect_button);

            // Extended info about network (hidden by revealer)
            var properties_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            properties_box.add(new Gtk.Separator(Gtk.Orientation.HORIZONTAL));
            properties_box.add(info_box);
            properties_box.add(new Gtk.Separator(Gtk.Orientation.HORIZONTAL));
            properties_box.add(bottom_box);

            // Setting a new instance of Gtk.Revealer
            properties_revealer = new Gtk.Revealer();
            properties_revealer.add(properties_box);

            row_content.add(row_header);
            row_content.add(properties_revealer);
            eventbox.add(row_content);
            this.add(eventbox);

        }



        public void toggle_revealer (){
            properties_revealer.set_reveal_child(!properties_revealer.get_reveal_child());
        }
    }
}

