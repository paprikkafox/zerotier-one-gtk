namespace AppComponents {

	public class CliTools {

        int StatusCode;
        string Error;
        string Output;

		public int connectToNetwork (string id) {

            new Thread<int>("add_network_nodes_to_view", () => {

            try {
		        Process.spawn_command_line_sync ("pkexec zerotier-cli join " + id,
									        out Output,
									        out Error,
									        out StatusCode);
			    print("[DEBUG] Connecting to network, status code - " + StatusCode.to_string() + "\n");
	        } catch (SpawnError e) {
	            print("[ERROR] Something happened when spawning CLI process " + e.code.to_string());
		        return(e.code);
	        }
                return(0);
		    });

		    return(0);

		}

	}

}
