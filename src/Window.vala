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
using App.Controllers;
using App.Views;
using App.Widgets;
using App.Utils;

namespace App {

    public class Window : Gtk.ApplicationWindow {

        public HeaderBar headerbar;
        public Gtk.Stack view_stack;

        public Window (Gtk.Application app) {
            
            Object (
                application: app,
                icon_name: Constants.APP_ICON,
                width_request: 500,
                height_request: 600,
                deletable : true,
                resizable : false
            );

            var settings = App.Configs.Settings.get_instance ();
            int x = settings.window_x;
            int y = settings.window_y;

            if (x != -1 && y != -1) {
                move (x, y);
            }
            
            style_provider ();

            headerbar = new HeaderBar();
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

            this.add(view_stack);

            view_stack.add_named(new WelcomeView (this, view_stack), "welcome-view"); 
            view_stack.add_named(new NetworksView (this), "networks-view"); 

            new AppController (this, this);
            //  var nwks = new NetworkUtil().networks_from_json_object(new NetworkUtil().get_list_of_networks());

        }
        
    }
}