/* main.vala
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

int main (string[] args) {
	var app = new Gtk.Application ("org.github.paprikkafox.zerotier-one-gtk", ApplicationFlags.FLAGS_NONE);
	app.activate.connect (() => {

		var win = app.active_window;

		var first_time = false;

		if (win == null) {
		    if (first_time == true){
                win = new AppComponents.Window (app);
                win.add(new AppComponents.WelcomeView());
		    } else {
				win = new AppComponents.Window (app);

                var network_list = new AppComponents.NetworkListView();

                win.add(network_list);

		    }

		}
		win.present ();
	});

	return app.run (args);
}
