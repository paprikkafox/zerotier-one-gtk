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
using App.Views;
using App.Widgets;
using App.Utils;

namespace App {

    public class Window : Gtk.ApplicationWindow {

        public HeaderBar headerbar;
        public Gtk.Stack view_stack;

        string [,] networks_array;
        int networks_array_lenght;

        public Window (Gtk.Application app) {
            
            Object (
                application: app,
                icon_name: Constants.APP_ICON,
                width_request: 550,
                height_request: 650,
                deletable : true,
                resizable : true
            );

            var settings = App.Configs.Settings.get_instance ();
            int x = settings.window_x;
            int y = settings.window_y;

            if (x != -1 && y != -1) {
                move (x, y);
            }
            
            style_provider ();

            headerbar = new HeaderBar();

            headerbar.add_network_button.clicked.connect (() => {
                var add_network_dialog = new App.Widgets.DialogAddNetwork(this, view_stack);
                add_network_dialog.show();
            });

            set_titlebar(headerbar);

            build (app);
        }

        private void style_provider () {
            var css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource (Constants.URL_CSS);
            
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

        private void build (Gtk.Application app) {

            view_stack = new Gtk.Stack();
            view_stack.set_transition_type(Gtk.StackTransitionType.CROSSFADE);

            view_stack.add_named(new WelcomeView (), "welcome-view");

            if (new NetworkUtil().check_auth_token() != 0){
                view_stack.add_named(new SetupScreenView (view_stack), "setup-screen-view");
                view_stack.set_visible_child_name("setup-screen-view");
                view_stack.get_child_by_name("setup-screen-view").show_all();
            } else {
                networks_array = new NetworkUtil().get_networks_array();
                networks_array_lenght = new NetworkUtil().get_networks_array_lenght();

                view_stack.add_named(new NetworksView (), "networks-view");

                if (networks_array_lenght == 0) {
                    view_stack.set_visible_child_name("welcome-view");
                    view_stack.get_child_by_name("welcome-view").show_all();
                } else {
                    view_stack.set_visible_child_name("networks-view");

                    new NetworksView().update_networks_view(networks_array, networks_array_lenght);

                    view_stack.get_child_by_name("networks-view").show_all();

                }
            }
            
            this.add(view_stack);
            
        }
        
    }
}