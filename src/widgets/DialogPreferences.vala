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

namespace App.Widgets {

    public class DialogPreferences : Gtk.Dialog {

        private App.Configs.Settings settings;

        public DialogPreferences (Gtk.Window parent) {
            this.resizable = false;
            this.deletable = false;
            this.set_transient_for (parent);
            this.set_default_size (500, 350);
            this.set_size_request (500, 350);
            this.set_modal (true);
            this.set_title("Settings");
            
            this.settings = App.Configs.Settings.get_instance ();

            var grid = new Gtk.Grid ();
            grid.row_spacing = 5;
            grid.column_spacing = 5;
            grid.margin = 12;
            grid.margin_top = 5;
            grid.margin_bottom = 5;

            var close_button = new Gtk.Button.with_label (Properties.CLOSE);
            close_button.clicked.connect (() => { this.destroy (); });
            grid.attach_next_to (close_button, null, Gtk.PositionType.RIGHT, 3, 1);

            this.get_content_area ().add (grid);
        }

        
    }
}