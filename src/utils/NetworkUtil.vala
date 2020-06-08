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

namespace App.Utils {

    public class NetworkUtil {

        public int StatusCode;
        public string Error;
        public string Output;

        public int connect_to_network_id (string network_id) {
            try {
                Process.spawn_command_line_sync ("pkexec zerotier-cli join " + network_id,
                                            out Output,
                                            out Error,
                                            out StatusCode);
                print("[DEBUG] Connecting to network, status code - " + StatusCode.to_string() + "\n");
            } catch (SpawnError e) {
                print("[ERROR] Something happened when spawning CLI process " + e.code.to_string());
                return(e.code);
            }
                
            return(0);
    
        }

        public string get_list_of_networks () {
            new Thread<int>("add_network_nodes_to_view", () => {
                try {
                    Process.spawn_command_line_sync ("pkexec zerotier-cli -j listnetworks",
                                                out Output,
                                                out Error,
                                                out StatusCode);
                    print("[DEBUG] Spawned ZeroTier CLI - ListNetworks\n");
    
                } catch (SpawnError e) {
                    print("[ERROR] Something happened when spawning CLI process - " + Error);
                    return(e.code);
                };
                return(0);
            });
            
            return(Output);
        }

        public string[,] networks_from_json_object(string networks_json){

            uint array_lenght;

            Json.Parser parser = new Json.Parser ();

            try {
		        parser.load_from_data(networks_json);

	        } catch (Error e) {
		        print("[ERROR] Catched a error while building JSON parser - " + e.code.to_string());
	        }

            Json.Node root = parser.get_root();

            var array = root.get_array();

            array_lenght = array.get_length();

            string[,] networks = new string[array_lenght + 1,5];

            var i = 0;
            for (i = 0; i < array_lenght; i++)
            {
                Json.Node node = array.get_element(i);

                Json.Object obj = node.get_object();

                string name = obj.get_string_member("name");
                string id = obj.get_string_member("id");
                string status = obj.get_string_member("status");
                string type = obj.get_string_member("type");


                var assignedAddressesArray = obj.get_array_member("assignedAddresses");
                var assignedAddressesString = "";

                var ip_num = 0;
                assignedAddressesArray.foreach_element(() => {
                    assignedAddressesString += "\n" + assignedAddressesArray.get_string_element(ip_num);
                    ip_num = ip_num + 1;
                });

                networks[0, 0] = array_lenght.to_string();

                if (name == ""){
                    name = "Not Authenticated network!";
                    networks[i + 1, 0] = name;
                } else {
                    networks[i + 1, 0] = name;
                }

                networks[i + 1, 1] = id;
                networks[i + 1, 2] = status;
                networks[i + 1, 3] = type;
                networks[i + 1, 4] = assignedAddressesString;

            }

            return(networks);
        }

        public int createAuthToken (){
            new Thread<int>("create_new_auth_token", () => {

                try {
                    Process.spawn_command_line_sync ("pkexec cat /var/lib/zerotier-one/authtoken.secret",
                                                out Output,
                                                out Error,
                                                out StatusCode);

                    var token = File.new_for_path (GLib.Environment.get_home_dir() + "/.zeroTierOneAuthToken");

                    try{
                        var file_stream = token.create (FileCreateFlags.NONE);
                        var data_stream = new DataOutputStream (file_stream);
                        data_stream.put_string (Output);
                    } catch (Error e){
                        print("[ERROR] Cannot create ZeroTier One auth token file");
                    };

                } catch (SpawnError e) {
                    print("[ERROR] Something happened when spawning CLI process - " + Error);
                    return(e.code);
                };

                return(0);

            });
            
            return(0);
        }
    }
}