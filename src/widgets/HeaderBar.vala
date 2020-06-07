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

        public signal void item_selected ();
        
        public Gtk.MenuButton app_menu;
        public Gtk.Menu       menu;   

        public HeaderBar () {
            this.set_title (Configs.Constants.PROGRAME_NAME);
            this.show_close_button = true;
            icon_settings ();
        }

        private void icon_settings () {
            this.app_menu = new Gtk.MenuButton();
            this.app_menu.set_image (new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.LARGE_TOOLBAR));
            this.app_menu.tooltip_text = Properties.SETTINGS;
            
            menu_settings ();
            
            this.app_menu.popup = this.menu;
            this.pack_end (this.app_menu);
        }

        private void menu_settings () {
            var about_item = new Gtk.MenuItem.with_label (Properties.PREFERENCES);
            about_item.activate.connect(() => {
                item_selected ();
            });

            this.menu = new Gtk.Menu ();
            this.menu.add (about_item);
            this.menu.show_all ();
        }
    }
}
