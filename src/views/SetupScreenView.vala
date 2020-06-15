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

using App.Views;
using App.Utils;

namespace App.Views {
    public class SetupScreenView : App.Views.WelcomeView{

        public Gtk.Button get_auth_button;

        public SetupScreenView(Gtk.Stack view_stack){

            base();

            get_auth_button = new Gtk.Button();
            get_auth_button.halign = Gtk.Align.CENTER;
            get_auth_button.margin_bottom = 35;
            get_auth_button.label = "Create";

            welcome_header.set_text("Creating auth token");
            welcome_description.set_text("Auth token is needed for using app without superuser rights. \n Click 'Create' to continue");
            welcome_image.set_from_icon_name("system-lock-screen", Gtk.IconSize.DIALOG);
            welcome_image.pixel_size = 128;

            this.add(get_auth_button);

            get_auth_button.clicked.connect (() => {
                new NetworkUtil().create_auth_token();
                if (new App.Utils.NetworkUtil().check_auth_token() == 0){
                    view_stack.set_visible_child_name("welcome-view");
                }
            });
        }
    }
}