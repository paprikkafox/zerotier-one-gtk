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
					parseJSON();
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

	    void parseJSON(){
	        print("hello!");
	    }

	}

}
