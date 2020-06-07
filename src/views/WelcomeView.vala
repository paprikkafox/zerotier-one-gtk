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

namespace App.Views {

    public class WelcomeView : Gtk.Box {

        public WelcomeView (Gtk.ApplicationWindow app, Gtk.Stack view_stack) {

            var welcome_box = new Granite.Widgets.Welcome("Stay connected", "To add some networks click 'Add' button below");
            welcome_box.append("network-vpn", "Add Network", "Enter ZeroTier One Network ID");

            welcome_box.activated.connect ((index) => {
                switch (index) {
                    case 0:
                        try {
                            var connect_dialog = new DialogAddNetwork (app, view_stack);
                            connect_dialog.show_all ();
                        } catch (Error e) {
                            warning (e.message);
                        }
    
                        break;
                }
            });
            this.add(welcome_box);
        }
    }
}