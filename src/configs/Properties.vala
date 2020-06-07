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

namespace App.Configs {

    /**
     * The {@code Properties} class is responsible for defining all 
     * the texts that are displayed in the application and must be translated.
     *
     * @since 0.1.0
     */
    public class Properties {
        public abstract const string CLOSE = _("Close");
        public abstract const string WELCOME = _("Welcome");
        public abstract const string PREFERENCES = _("Preferences");
        public abstract const string SETTINGS = _("Settings");
    }
}