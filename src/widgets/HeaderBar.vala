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

    public class HeaderBar : Gtk.HeaderBar {
        
        public Gtk.Button add_network_button;

        public HeaderBar () {
            this.set_title (Configs.Constants.PROGRAME_NAME);
            this.show_close_button = true;

            this.add_network_button = new Gtk.Button();
            this.add_network_button.set_image(new Gtk.Image.from_icon_name ("add-symbolic", Gtk.IconSize.LARGE_TOOLBAR));
            this.pack_start(this.add_network_button);
            
        }

    }
}
