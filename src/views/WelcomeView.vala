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

        public WelcomeView () {

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

        }
    }
}