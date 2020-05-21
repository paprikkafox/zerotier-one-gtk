namespace AppComponents {

	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/views/network-list-view.ui")]
	public class NetworkListView : Gtk.Box {
	[GtkChild] public Gtk.ListBox network_list_box;
	    public NetworkListView (){

	    }

	}

}
