namespace AppComponents {

	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/views/network-list-view.ui")]
	public class NetworkListView : Gtk.Box {
	[GtkChild] public Gtk.ListBox network_list_box;

        public string NetworksListJson;
	    public string NetworksListError;
	    public int NetworksListStatus;
        public uint array_lenght;

	    public NetworkListView (){

			new Thread<int>("add_network_nodes_to_view", () => {

				reciveNetworkList();
				if (NetworksListJson != ""){
					print("[DEBUG] Recived Networks JSON. Code - " + NetworksListStatus.to_string() + "\n");
                    var networks = NetworkfromJsonObject();

                    var i = 0;
                    for(i = 0; i < array_lenght; i++){
                        network_list_box.add(new AppComponents.NetworkRow(networks[i, 0], networks[i, 1], networks[i, 2], networks[i, 3], networks[i, 4]));
                    }


				} else {
				    print("[ERROR]" + NetworksListError + "Error Code - " + NetworksListStatus.to_string() + "\n");
				}

                return(0);
		    });



	    }

	    int reciveNetworkList(){

            try {
		        Process.spawn_command_line_sync ("pkexec zerotier-cli -j listnetworks",
									        out NetworksListJson,
									        out NetworksListError,
									        out NetworksListStatus);
			    print("[DEBUG] Spawned ZeroTier CLI - ListNetworks\n");

	        } catch (SpawnError e) {
	            print("[ERROR] Something happened when spawning CLI process " + e.code.to_string());
		        return(e.code);
	        }
	        return(0);

	    }

        public string[,] NetworkfromJsonObject(){

            Json.Parser parser = new Json.Parser ();

            try {
		        parser.load_from_data(NetworksListJson);

	        } catch (Error e) {
		        print("[ERROR] Catched a error while building JSON parser - " + e.code.to_string());
	        }

            Json.Node root = parser.get_root();

            var array = root.get_array();

            array_lenght = array.get_length();

            string[,] networks = new string[array_lenght,5];

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

                if (name == ""){
                    name = "Not Authenticated network!";
                    networks[i, 0] = name;
                } else {
                    networks[i, 0] = name;
                }

                networks[i, 1] = id;
                networks[i, 2] = status;
                networks[i, 3] = type;
                networks[i, 4] = assignedAddressesString;

            }

            return(networks);
        }

	}

}
