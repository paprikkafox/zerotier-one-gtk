/* window.vala
 *
 * Copyright 2020 Dmitry Fox
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace ZeroTierOneGTK {
	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/mainwindow.ui")]
	public class Window : Gtk.ApplicationWindow {

	[GtkChild] Gtk.ListBox network_list_box;
	[GtkChild] Gtk.ListBoxRow network_row;
	[GtkChild] Gtk.Label connection_status_label;

		public Window (Gtk.Application app) {
			Object (application: app);
            setText();
		}

		public void setText (){
            network_row.visible = false;
		}
	}
}
