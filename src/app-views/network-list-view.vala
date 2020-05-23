namespace AppComponents {

	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/views/network-list-view.ui")]
	public class NetworkListView : Gtk.Box {
	[GtkChild] public Gtk.ListBox network_list_box;


        public string NetworksListJson;
	    public string NetworksListError;
	    public int NetworksListStatus;

	    public NetworkListView (){

			new Thread<int>("", () => {

				reciveNetworkList();
				if (NetworksListJson != ""){
					print("Recived Networks JSON. Error Code - " + NetworksListStatus.to_string() + "\n");
                    NetworkfromJsonObject();
				} else {
				    print(NetworksListError + "Error Code - " + NetworksListStatus.to_string() + "\n");
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

	        } catch (SpawnError e) {
		        return(e.code);
	        }
	        return(0);

	    }

        public void NetworkfromJsonObject(){

            Json.Parser parser = new Json.Parser ();
            parser.load_from_data(NetworksListJson);
            Json.Node root = parser.get_root();

            var arrays = root.get_array();

            var i = 0;
            for (i = 0; i < arrays.get_length(); i++)
            {
                Json.Node node = arrays.get_element(i);

                Json.Object obj = node.get_object();

                string id = obj.get_string_member("id");
                string name = obj.get_string_member("name");
                string status = obj.get_string_member("status");
                string type = obj.get_string_member("type");
                string mac = obj.get_string_member("mac");

                var assignedAddresses = obj.get_array_member("assignedAddresses").get_string_element(0);

                print("\n");
                print(id + "\n");
                print(assignedAddresses + "\n");
                print(name + "\n");
                print(status + "\n");
                print(type + "\n");
                print(mac + "\n");
                print("\n");
            }




        }

	}

}
