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

    public class NetworksView : Gtk.Box{

        public NetworkList network_list;

        public NetworksView (Gtk.ApplicationWindow app) {

            var scrolled_window = new Gtk.ScrolledWindow(null, null);
            var viewport = new Gtk.Viewport(null, null);
            scrolled_window.add(viewport);

            network_list = new App.Widgets.NetworkList();

            network_list.add(new App.Widgets.NetworkRow());
            network_list.add(new App.Widgets.NetworkRow());
            network_list.add(new App.Widgets.NetworkRow());


            viewport.add(network_list);
            
            this.add(scrolled_window);
        }
    }
}